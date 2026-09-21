(() => {
  const detailsItems = [...document.querySelectorAll('details')];
  if (!detailsItems.length) return;

  const reducedMotion = matchMedia('(prefers-reduced-motion: reduce)');

  detailsItems.forEach(details => {
    const summary = details.querySelector(':scope > summary');
    if (!summary) return;

    const content = document.createElement('div');
    const inner = document.createElement('div');
    content.className = 'details-motion__content';
    inner.className = 'details-motion__inner';

    while (summary.nextSibling) {
      inner.append(summary.nextSibling);
    }

    content.append(inner);
    details.append(content);
    details.classList.toggle('is-open', details.open);

    summary.addEventListener('click', event => {
      event.preventDefault();

      const shouldOpen = !details.classList.contains('is-open');
      if (reducedMotion.matches) {
        details.open = shouldOpen;
        details.classList.toggle('is-open', shouldOpen);
        return;
      }

      if (shouldOpen) {
        details.open = true;
        requestAnimationFrame(() => {
          details.classList.add('is-open');
        });
      } else {
        details.classList.remove('is-open');
      }
    });

    content.addEventListener('transitionend', event => {
      if (event.propertyName !== 'grid-template-rows') return;
      if (!details.classList.contains('is-open')) details.open = false;
    });
  });

  document.documentElement.classList.add('details-motion-ready');
})();
