fetch(`http://127.0.0.1:${window.wr.servicePort}/api/app/health`)
  .then(r => r.json()).then(j => { document.getElementById('out').textContent = JSON.stringify(j); })
  .catch(e => { document.getElementById('out').textContent = 'service unreachable: ' + e; });
