(() => {
  const revealSelectors = [
    '.intro-copy',
    '.principle',
    '.experience-meta',
    '.experience-content',
    '.outcomes > details',
    '#glamdog > .shell > .section-head',
    '.product-index__row',
    '.bot-flow__head',
    '.bot-flow__step',
    '.product-direction__intro',
    '.design-decisions > div',
    '.case',
    '#projects .section-head',
    '.project-study',
    '#skills h2',
    '.skill-group',
  ];

  const textGroups = [
    ['.intro-copy', ':scope > h2, :scope > p'],
    ['.principle', ':scope > strong, :scope > p'],
    ['.experience-meta', ':scope > strong, :scope > span'],
    ['.experience-content', ':scope > h2, :scope > p'],
    ['.outcomes > details', ':scope > summary, :scope > .outcome-body'],
    ['#glamdog > .shell > .section-head', ':scope > h2, :scope > p'],
    ['.product-index__row', ':scope > .product-index__number, :scope > .product-index__identity, :scope > p, :scope > .status'],
    ['.bot-flow__head', ':scope > .bot-flow__label, :scope > h3'],
    ['.bot-flow__step', ':scope > span, :scope > strong, :scope > p'],
    ['.product-direction__intro', '.product-direction__label, h3, .product-direction__copy'],
    ['.design-decisions > div', ':scope > dt, :scope > dd'],
    ['.case', ':scope > .case__identity > .status, :scope > .case__identity > h3, :scope > .case__identity > p'],
    ['#projects .section-head', ':scope > h2, :scope > p'],
    ['.project-study', ':scope > .work-card__content > h3, :scope > .work-card__content > .work-card__summary, :scope > .work-card__content > .work-card__meta, :scope > .work-card__content > .miniapp-entry'],
    ['.skill-group', ':scope > h3, :scope > p'],
  ];

  const revealItems = [
    ...new Set(revealSelectors.flatMap(selector => [...document.querySelectorAll(selector)])),
  ];
  const panel = document.querySelector('.contact-panel');
  revealItems.forEach(item => {
    item.dataset.scrollReveal = '';
  });

  textGroups.forEach(([groupSelector, itemSelector]) => {
    document.querySelectorAll(groupSelector).forEach(group => {
      group.querySelectorAll(itemSelector).forEach((item, index) => {
        item.dataset.revealText = '';
        item.style.setProperty('--text-reveal-delay', `${70 + Math.min(index, 4) * 50}ms`);
      });
    });
  });

  const reducedMotion = matchMedia('(prefers-reduced-motion: reduce)');
  document.documentElement.classList.add('scroll-reveal-ready');
  document.documentElement.classList.add('contact-reveal-ready');

  if (!('IntersectionObserver' in window)) {
    revealItems.forEach(item => {
      item.dataset.visible = '';
    });
    if (panel) panel.dataset.visible = '';
    return;
  }

  const revealObserver = new IntersectionObserver(
    entries => {
      const entering = entries
        .filter(entry => entry.isIntersecting)
        .sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top);

      entering.forEach((entry, index) => {
        entry.target.style.setProperty('--reveal-delay', `${Math.min(index, 3) * 55}ms`);
        entry.target.dataset.visible = '';
        revealObserver.unobserve(entry.target);
      });
    },
    {
      rootMargin: reducedMotion.matches ? '0px' : '0px 0px -10%',
      threshold: reducedMotion.matches ? 0 : 0.08,
    },
  );

  revealItems.forEach(item => revealObserver.observe(item));

  if (!panel) return;

  const contactObserver = new IntersectionObserver(
    entries => {
      if (!entries.some(entry => entry.isIntersecting)) return;
      panel.dataset.visible = '';
      contactObserver.disconnect();
    },
    {
      rootMargin: reducedMotion.matches ? '0px' : '0px 0px -80px',
      threshold: reducedMotion.matches ? 0 : 0.2,
    },
  );

  contactObserver.observe(panel);
})();
