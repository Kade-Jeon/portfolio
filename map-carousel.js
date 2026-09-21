(() => {
  const root = document.querySelector('.map-carousel');
  if (!root) return;
  const track = root.querySelector('.map-carousel__track');
  const slides = [...root.querySelectorAll('.map-carousel__slide')];
  const viewport = root.querySelector('.map-carousel__viewport');
  const status = root.querySelector('.map-carousel__status');
  const play = root.querySelector('[data-action="play"]');
  const disclosure = root.closest('details');
  const reducedMotion = matchMedia('(prefers-reduced-motion: reduce)');
  let index = 0;
  let playing = false;
  let timer;
  let inView = false;
  let hovering = false;
  let gesture = null;
  let suppressClick = false;

  function schedule() {
    clearTimeout(timer);
    if (playing && inView && !hovering && !document.hidden && disclosure.open) {
      timer = setTimeout(() => show(index + 1), 5000);
    }
  }

  function setPlaying(value) {
    playing = value;
    play.textContent = value ? '일시정지' : '자동 재생';
    play.setAttribute('aria-pressed', String(value));
    status.setAttribute('aria-live', value ? 'off' : 'polite');
    schedule();
  }

  function show(next, instant = false) {
    if (slides.some(slide => slide.contains(document.activeElement))) {
      root.focus({preventScroll:true});
    }
    index = (next + slides.length) % slides.length;
    track.classList.toggle('is-instant', instant || reducedMotion.matches);
    track.style.transform = `translateX(-${index * 100}%)`;
    slides.forEach((slide, position) => {
      slide.inert = position !== index;
      slide.setAttribute('aria-hidden', String(position !== index));
      slide.setAttribute('role', 'group');
      slide.setAttribute('aria-roledescription', '슬라이드');
      slide.setAttribute('aria-label', `${position + 1} / ${slides.length}`);
    });
    status.textContent = `${index + 1} / ${slides.length} · ${slides[index].dataset.title}`;
    slides[index].querySelector('img').loading = 'eager';
    schedule();
  }

  root.querySelector('[data-action="previous"]').addEventListener('click', event => {
    setPlaying(false);
    show(index - 1, event.detail === 0);
  });
  root.querySelector('[data-action="next"]').addEventListener('click', event => {
    setPlaying(false);
    show(index + 1, event.detail === 0);
  });
  play.addEventListener('click', () => setPlaying(!playing));
  root.addEventListener('keydown', event => {
    if (!['ArrowLeft', 'ArrowRight', 'Home', 'End'].includes(event.key)) return;
    event.preventDefault();
    setPlaying(false);
    show(event.key === 'Home' ? 0 : event.key === 'End' ? slides.length - 1 : index + (event.key === 'ArrowRight' ? 1 : -1), true);
  });
  root.addEventListener('focusin', () => setPlaying(false));
  root.addEventListener('pointerenter', event => {
    if (event.pointerType === 'mouse') { hovering = true; schedule(); }
  });
  root.addEventListener('pointerleave', event => {
    if (event.pointerType === 'mouse') { hovering = false; schedule(); }
  });
  viewport.addEventListener('pointerdown', event => {
    if (!event.isPrimary || event.button !== 0) return;
    gesture = {id:event.pointerId, x:event.clientX, y:event.clientY};
    suppressClick = false;
    setPlaying(false);
  });
  viewport.addEventListener('pointerup', event => {
    if (!gesture || gesture.id !== event.pointerId) return;
    const dx = event.clientX - gesture.x;
    const dy = event.clientY - gesture.y;
    gesture = null;
    if (Math.abs(dx) > 45 && Math.abs(dx) > Math.abs(dy) * 1.2) {
      suppressClick = true;
      show(index + (dx < 0 ? 1 : -1));
    }
  });
  viewport.addEventListener('pointercancel', () => { gesture = null; });
  viewport.addEventListener('click', event => {
    if (suppressClick) { event.preventDefault(); suppressClick = false; }
  }, true);
  new MutationObserver(() => {
    if (!disclosure.open) setPlaying(false);
  }).observe(disclosure, {attributes:true, attributeFilter:['open']});
  document.addEventListener('visibilitychange', schedule);
  reducedMotion.addEventListener('change', () => {
    setPlaying(false);
    show(index, true);
  });
  new IntersectionObserver(entries => {
    inView = entries[0].isIntersecting;
    schedule();
  }, {threshold:0.1}).observe(root);
  slides.forEach(slide => {
    const img = slide.querySelector('img');
    const showError = () => {
      if (slide.querySelector('.map-carousel__error')) return;
      const message = document.createElement('p');
      message.className = 'map-carousel__error';
      message.textContent = '이미지를 불러오지 못했습니다. 새로고침하거나 이미지 링크를 열어 주세요.';
      slide.append(message);
    };
    img.addEventListener('error', showError);
    if (img.complete && img.naturalWidth === 0) showError();
  });
  root.classList.add('is-ready');
  show(0, true);
})();
