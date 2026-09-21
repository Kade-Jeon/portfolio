const {chromium}=await import(process.env.PLAYWRIGHT_MODULE || 'playwright');
import assert from 'node:assert/strict';
const browser=await chromium.launch({headless:true});
const report=[];
try {
 for(const width of [390,1440]) {
  const context=await browser.newContext({viewport:{width,height:900},hasTouch:true});
  const page=await context.newPage();
  const errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.clock.install();
  await page.goto((process.env.PORTFOLIO_URL || 'http://127.0.0.1:4173/'),{waitUntil:'networkidle'});
  await page.getByText('Glamdog Map 추가 화면과 기술 구조',{exact:true}).click();
  const root=page.getByRole('region',{name:'글램독 현장 안내 이미지'});
  const galleryBox=await root.boundingBox();
  const flowBox=await page.getByLabel('Glamdog Map 제작과 운영 흐름').boundingBox();
  if(width>900) {
   assert.ok(flowBox.x>=galleryBox.x+galleryBox.width, 'Technical explanation stays beside the photo slider');
   assert.ok(Math.abs(flowBox.y-galleryBox.y)<2, 'Photo and explanation align at the top');
  } else {
   assert.ok(flowBox.y>=galleryBox.y+galleryBox.height, 'Mobile evidence stacks below the slider');
  }
  const status=root.locator('.map-carousel__status');
  const next=root.getByRole('button',{name:'다음 안내 이미지'});
  const prev=root.getByRole('button',{name:'이전 안내 이미지'});
  assert.match(await status.textContent(),/^1 \/ 11/);
  await prev.click(); assert.match(await status.textContent(),/^11 \/ 11/);
  await next.click(); assert.match(await status.textContent(),/^1 \/ 11/);
  await root.focus(); await root.press('ArrowRight'); assert.match(await status.textContent(),/^2 \/ 11/);
  await root.press('End'); assert.match(await status.textContent(),/^11 \/ 11/);
  await root.press('Home'); assert.match(await status.textContent(),/^1 \/ 11/);
  for(let i=0;i<11;i++) {
   const img=root.locator('.map-carousel__slide[aria-hidden="false"] img');
   await img.evaluate(img=>img.decode());
   assert.equal(await root.locator('.map-carousel__slide:not([inert])').count(),1);
   await next.click();
  }
  const play=root.locator('[data-action="play"]');
  await play.click(); await page.mouse.move(1,1); await page.clock.runFor(5200);
  assert.match(await status.textContent(),/^2 \/ 11/);
  await play.click(); await page.clock.runFor(5200); assert.match(await status.textContent(),/^2 \/ 11/);
  await page.emulateMedia({reducedMotion:'reduce'});
  await next.click();
  assert.equal(await root.locator('.map-carousel__track').evaluate(el=>getComputedStyle(el).transitionDuration),'0s');
  if(width===390) {
   await root.scrollIntoViewIfNeeded();
   const box=await root.locator('.map-carousel__viewport').boundingBox();
   const cdp=await context.newCDPSession(page);
   const x=box.x+box.width*0.8,y=box.y+box.height/2;
   await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{x,y}]});
   await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:x-100,y}]});
   await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});
   assert.match(await status.textContent(),/^4 \/ 11/);
  }
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),true);
  await root.screenshot({path:`/private/tmp/map-slider-${width}.png`});
  await page.locator('#glamdog-map .case-evidence__body').screenshot({path:`/private/tmp/map-evidence-${width}.png`});
  await play.click();
  await page.getByText('Glamdog Map 추가 화면과 기술 구조',{exact:true}).click();
  await page.clock.runFor(100);
  assert.equal(await page.locator('.map-carousel [data-action="play"]').getAttribute('aria-pressed'),'false');
  assert.deepEqual(errors,[]);
  report.push({width,wrap:true,keyboard:true,imagesLoaded:11,autoplay:true,pause:true,reducedMotion:true,swipe:width===390,overflow:false});
  await context.close();
 }
 const page=await browser.newPage();
 await page.route('**/glamdog-slides/1.webp',route=>route.abort());
 await page.goto((process.env.PORTFOLIO_URL || 'http://127.0.0.1:4173/'),{waitUntil:'networkidle'});
 await page.getByText('Glamdog Map 추가 화면과 기술 구조',{exact:true}).click();
 await page.getByText('이미지를 불러오지 못했습니다. 새로고침하거나 이미지 링크를 열어 주세요.').waitFor();
 report.push({missingImage:'inline error shown'});
 console.log(JSON.stringify(report,null,2));
} finally {await browser.close();}
