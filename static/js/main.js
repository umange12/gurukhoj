// GuruKhoj — main.js

// Theme toggle
function toggleTheme() {
  const html = document.documentElement;
  const current = html.getAttribute('data-theme');
  const next = current === 'dark' ? 'light' : 'dark';
  html.setAttribute('data-theme', next);
  localStorage.setItem('gk-theme', next);
  document.querySelector('.theme-btn').textContent = next === 'dark' ? '☀️' : '🌙';
}
(function() {
  const saved = localStorage.getItem('gk-theme') || 'light';
  document.documentElement.setAttribute('data-theme', saved);
  const btn = document.querySelector('.theme-btn');
  if (btn) btn.textContent = saved === 'dark' ? '☀️' : '🌙';
})();

// Chatbot
let chatOpen = true;
function toggleChat() {
  chatOpen = !chatOpen;
  document.getElementById('chatBody').style.display = chatOpen ? 'flex' : 'none';
  document.getElementById('chatArrow').textContent = chatOpen ? '▲' : '▼';
}

async function sendChat() {
  const input = document.getElementById('chatIn');
  const msg = input.value.trim();
  if (!msg) return;
  input.value = '';
  const msgs = document.getElementById('chatMsgs');
  msgs.innerHTML += `<div class="msg user">${msg}</div>`;
  msgs.scrollTop = msgs.scrollHeight;
  try {
    const res = await fetch('/api/chatbot', {
      method: 'POST', headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({message: msg})
    });
    const data = await res.json();
    msgs.innerHTML += `<div class="msg bot">${data.response}</div>`;
  } catch(e) {
    msgs.innerHTML += `<div class="msg bot">Sorry, I'm having trouble connecting. Please try again!</div>`;
  }
  msgs.scrollTop = msgs.scrollHeight;
}

// Set today's date on date inputs
document.addEventListener('DOMContentLoaded', () => {
  const today = new Date().toISOString().split('T')[0];
  document.querySelectorAll('input[type="date"]').forEach(i => { if (!i.value) i.value = today; });
});
