(function() {
  const STORAGE_KEY = 'theme-preference';
  
  const getTheme = () => {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored || 'auto';
  };
  
  const setTheme = (theme) => {
    localStorage.setItem(STORAGE_KEY, theme);
    if (theme === 'auto') {
      document.documentElement.removeAttribute('data-theme');
    } else {
      document.documentElement.setAttribute('data-theme', theme);
    }
  };
  
  const cycleTheme = () => {
    const current = getTheme();
    const themes = ['auto', 'light', 'dark'];
    const currentIndex = themes.indexOf(current);
    const nextIndex = (currentIndex + 1) % themes.length;
    const next = themes[nextIndex];
    
    setTheme(next);
    updateToggleButton(next);
  };
  
  const updateToggleButton = (theme) => {
    const button = document.getElementById('theme-toggle');
    if (!button) return;
    
    const icons = {
      auto: '◐',
      light: '☀',
      dark: '☾'
    };
    
    const labels = {
      auto: 'Auto theme',
      light: 'Light theme', 
      dark: 'Dark theme'
    };
    
    button.textContent = icons[theme];
    button.setAttribute('aria-label', `Current: ${labels[theme]}. Click to change theme`);
    button.setAttribute('title', labels[theme]);
  };
  
  // Initialize theme on page load
  document.addEventListener('DOMContentLoaded', () => {
    const theme = getTheme();
    setTheme(theme);
    
    const button = document.getElementById('theme-toggle');
    if (button) {
      button.addEventListener('click', cycleTheme);
      updateToggleButton(theme);
    }
  });
})();