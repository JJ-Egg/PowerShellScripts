$data = Invoke-RestMethod -Method Get -Uri 'https://www.reddit.com/.json'

$data.data.children[0].data.score