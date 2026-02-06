function handler(event) {
  var request = event.request;
  var uri = request.uri;

  // If URI ends with '/', append 'index.html'
  if (uri.endsWith('/')) {
    request.uri += 'index.html';
    return request;
  }

  // If URI has no '.' (no file extension), treat it as a "clean URL"
  // and append '/index.html'
  if (!uri.includes('.')) {
    request.uri += '/index.html';
    return request;
  }

  return request;
}