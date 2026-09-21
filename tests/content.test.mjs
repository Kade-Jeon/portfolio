import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const html = readFileSync(new URL('../index.html', import.meta.url), 'utf8');
const scrollReveal = readFileSync(new URL('../scroll-reveal.js', import.meta.url), 'utf8');
const detailsMotion = readFileSync(new URL('../details-motion.js', import.meta.url), 'utf8');
const article = (id) => html.match(new RegExp(`<article[^>]*id="${id}"[\\s\\S]*?<\\/article>`))?.[0] ?? '';

test('AI Assistant and Berita have independent project articles', () => {
  assert.ok(article('ai-assistant'));
  assert.ok(article('berita'));
  assert.ok(!html.includes('class="selected-grid"'));
});

test('AI Assistant exposes its original architecture and full-size link', () => {
  const ai = article('ai-assistant');
  assert.match(ai, /<img[^>]*src="\.\/images\/arch\.svg"/);
  assert.match(ai, /href="\.\/images\/arch\.svg"/);
  assert.match(ai, /시스템 아키텍처/);
});

test('AI Assistant preserves design decisions and troubleshooting', () => {
  const ai = article('ai-assistant');
  for (const term of ['Tool-based RAG', 'IdempotencyStateHandler', 'CustomChatMemoryRepository', 'Langfuse', 'Redis', 'Vue 3', 'ReadableStream']) {
    assert.ok(ai.includes(term), `Missing technical evidence: ${term}`);
  }
  assert.ok((ai.match(/<details/g) ?? []).length >= 4);
});

test('AI Assistant restores demo and all six original screenshots', () => {
  const ai = article('ai-assistant');
  assert.match(ai, /<iframe[^>]*src="https:\/\/www.youtube.com\/embed\/zCKpgnd4DGY/);
  for (const image of ['sse-chat', 'rag-result', 'langfuse-trace', 'chat-list', 'dashboard', 'markdown']) {
    assert.ok(ai.includes(`./images/${image}.png`), `Missing screenshot: ${image}`);
  }
});

test('project media is collapsed by default behind an explicit disclosure', () => {
  for (const id of ['ai-assistant', 'berita']) {
    const project = article(id);
    assert.match(project, /<details class="project-disclosure">\s*<summary[^>]*>/);
    assert.doesNotMatch(project, /<details class="project-disclosure"[^>]*\bopen\b/);
    assert.ok(project.indexOf('class="project-disclosure"') < project.indexOf('<figure'));
  }
});

test('Berita architecture is inside the disclosure, without stretching', () => {
  const berita = article('berita');
  assert.match(berita, /<\/header>\s*<details class="project-disclosure">/);
  assert.match(berita, /src="\.\/images\/berita-arch.svg"/);
  assert.doesNotMatch(html, /\.work-card--secondary[^}]*flex:\s*1/s);
});

test('local image references resolve and hash anchors are valid', () => {
  for (const [, src] of html.matchAll(/<img[^>]*src="(\.\/images\/[^"]+)"/g)) {
    assert.ok(existsSync(fileURLToPath(new URL(`../${src}`, import.meta.url))), src);
  }
  for (const [, id] of html.matchAll(/href="#([^"]+)"/g)) {
    assert.ok(html.includes(`id="${id}"`), `Missing anchor: ${id}`);
  }
});

test('each Glamdog project has one real preview before collapsed supporting evidence', () => {
  const previews = {
    'accommodation-bot': 'glamdog-bot.png',
    'glamdog-pms': 'glamdog-pms.png',
    'glamdog-map': 'glamdog-map.png',
  };
  for (const [id, filename] of Object.entries(previews)) {
    const project = article(id);
    assert.ok(project.includes(`src="./images/${filename}"`), `${id}: missing preview`);
    assert.ok(project.includes(`href="./images/${filename}"`), `${id}: missing full-size link`);
    assert.equal((project.match(/class="case-preview"/g) ?? []).length, 1);
    assert.match(project, /<details class="case-evidence">/);
    assert.doesNotMatch(project, /<details class="case-evidence"[^>]*\bopen\b/);
    assert.ok(project.indexOf('class="case-preview"') < project.indexOf('class="case-evidence"'));
    assert.match(project, /class="case-flow"/);
  }
});

test('additional captures have honest captions and remain available', () => {
  assert.match(article('accommodation-bot'), /glamdog-bot-response\.png/);
  assert.match(article('accommodation-bot'), /제한 응답/);
  assert.match(article('glamdog-pms'), /glamdog-checkin\.png/);
  assert.match(article('glamdog-pms'), /웰컴 체크인/);
  assert.match(article('glamdog-map'), /class="map-carousel"/);
  assert.match(article('glamdog-map'), /실행 화면/);
});

test('Map gallery uses real artwork with accessible slider controls', () => {
  const map = article('glamdog-map');
  for(const n of [1,3,4,5,6,7,8,9,10,11,12]) {
    assert.ok(map.includes(`./images/glamdog-slides/${n}.webp`), `Missing slide ${n}`);
  }
  assert.ok(!map.includes('./images/glamdog-slides/2.webp'));
  assert.ok(!map.includes('glamdog-map-guide.png'));
  for(const label of ['이전 안내 이미지', '다음 안내 이미지', '자동 재생']) assert.ok(map.includes(label));
  assert.match(map, /aria-roledescription="캐러셀"/);
  assert.match(map, /aria-live="polite"/);
  assert.match(html, /src="\.\/map-carousel\.js"/);
});

test('Glamdog overview separates the three products without implying a shared architecture', () => {
  const overview = html.match(/<div class="product-index"[\s\S]*?<aside class="product-direction"/)?.[0] ?? '';
  for (const [id, status] of [
    ['accommodation-bot', '양양점 베타 준비'],
    ['glamdog-pms', '레거시 전환 개발 중'],
    ['glamdog-map', '양양점 현장 운영 중'],
  ]) {
    assert.ok(overview.includes(`href="#${id}"`), `Missing product link: ${id}`);
    assert.ok(overview.includes(status), `Missing product status: ${status}`);
  }
  assert.ok(!html.includes('class="ecosystem"'));
  assert.ok(!html.includes('ecosystem__foundation'));
  assert.match(html, /Next phase · CRM\/PMS/);
});

test('Accommodation Bot overview keeps a distinct three-step request flow', () => {
  const flow = html.match(/<section class="bot-flow"[\s\S]*?<\/section>/)?.[0] ?? '';
  for (const term of ['Customer context', 'Skill and policy', 'Safe response', '검증된 답변 / 현장 연결']) {
    assert.ok(flow.includes(term), `Missing Bot flow step: ${term}`);
  }
  assert.equal((flow.match(/class="bot-flow__arrow"/g) ?? []).length, 2);
  assert.ok(html.indexOf('class="product-index"') < html.indexOf('class="bot-flow"'));
  assert.ok(html.indexOf('class="bot-flow"') < html.indexOf('class="product-direction"'));
});

test('contact panel keeps the page palette in dark mode', () => {
  const styles = html.match(/<style>([\s\S]*?)<\/style>/)?.[1] ?? '';
  const panel = styles.match(/\.contact-panel \{([\s\S]*?)\n      \}/)?.[1] ?? '';
  assert.match(panel, /background:\s*var\(--surface-strong\)/);
  assert.match(panel, /color:\s*var\(--ink\)/);
  assert.doesNotMatch(panel, /background:\s*var\(--ink\)/);
});

test('contact panel reveals once on scroll with reduced-motion support', () => {
  assert.match(html, /src="\.\/scroll-reveal\.js"/);
  assert.match(scrollReveal, /IntersectionObserver/);
  assert.match(scrollReveal, /contactObserver\.disconnect\(\)/);
  assert.match(scrollReveal, /prefers-reduced-motion: reduce/);
  assert.match(html, /\.contact-reveal-ready \.contact-panel\[data-visible\]/);
  assert.match(html, /transition-duration:\s*200ms !important/);
});

test('content sections reveal once with a short bounded stagger', () => {
  for (const selector of [
    '.intro-copy',
    '.outcomes > details',
    '.product-index__row',
    '.case',
    '.project-study',
    '.skill-group',
  ]) {
    assert.ok(scrollReveal.includes(`'${selector}'`), `Missing reveal target: ${selector}`);
  }
  assert.match(scrollReveal, /revealObserver\.unobserve\(entry\.target\)/);
  assert.match(scrollReveal, /Math\.min\(index, 3\) \* 55/);
  assert.match(html, /\.scroll-reveal-ready \[data-scroll-reveal\]\[data-visible\]/);
  assert.match(html, /translateY\(18px\)/);
});

test('scroll reveal extends the contact text rhythm to content groups', () => {
  for (const selector of [
    '.intro-copy',
    '.principle',
    '.experience-content',
    '.product-index__row',
    '.bot-flow__step',
    '.case',
    '.project-study',
    '.skill-group',
  ]) {
    assert.ok(scrollReveal.includes(`'${selector}'`), `Missing text reveal group: ${selector}`);
  }
  assert.match(scrollReveal, /item\.dataset\.revealText/);
  assert.match(scrollReveal, /70 \+ Math\.min\(index, 4\) \* 50/);
  assert.match(html, /\[data-scroll-reveal\] \[data-reveal-text\]/);
  assert.match(html, /translateY\(12px\)/);
});

test('drawers animate their content and respect reduced motion', () => {
  assert.match(html, /src="\.\/details-motion\.js"/);
  assert.match(detailsMotion, /querySelectorAll\('details'\)/);
  assert.match(detailsMotion, /requestAnimationFrame/);
  assert.match(detailsMotion, /transitionend/);
  assert.match(detailsMotion, /prefers-reduced-motion: reduce/);
  assert.match(html, /grid-template-rows:\s*0fr/);
  assert.match(html, /grid-template-rows:\s*1fr/);
});

test('Berita mini app link identifies its mobile-only availability', () => {
  const berita = article('berita');
  assert.match(berita, /class="miniapp-entry"/);
  assert.match(berita, /토스 미니앱 열기/);
  assert.match(berita, /모바일에서만 이용 가능/);
});
