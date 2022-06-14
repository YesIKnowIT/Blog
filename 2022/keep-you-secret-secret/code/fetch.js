const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('http://localhost:3400/index.html');
  
  const text = await page.$eval('body', (el) => el.innerText);

  console.dir(text);

  await browser.close();
})();
