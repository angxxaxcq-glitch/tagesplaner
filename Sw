// Service Worker – ✨ Mein Plan
const CACHE = 'mein-plan-v1';

self.addEventListener('install', e => {
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil(clients.claim());
});

// Handle notification clicks
self.addEventListener('notificationclick', e => {
  e.notification.close();
  e.waitUntil(
    clients.matchAll({type:'window'}).then(cls => {
      if(cls.length > 0) { cls[0].focus(); return; }
      return clients.openWindow('./mein-plan.html');
    })
  );
});

// Handle scheduled alarms via periodicsync or message
self.addEventListener('message', e => {
  if(e.data && e.data.type === 'SCHEDULE_NOTIFICATIONS') {
    // Just acknowledge – scheduling is done from the page
  }
});
