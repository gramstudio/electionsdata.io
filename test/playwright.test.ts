import { test, expect } from '@playwright/test';

test('healthcheck', async ({ page }) => {
  // Navigate to the root page
  await page.goto('http://localhost:3000/');

  // Expect the h1 tag to contain the text "yay"
  const h1 = page.locator('h1');
  await expect(h1).toContainText('yay');
});

export {};
