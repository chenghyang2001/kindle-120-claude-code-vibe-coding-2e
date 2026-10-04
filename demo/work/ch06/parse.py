import json,sys
for l in open(sys.argv[1],encoding='utf-8'):
    d=json.loads(l)
    if d.get('type')=='assistant':
        for c in d['message']['content']:
            if c.get('type')=='tool_use': print('  call', c['name'], json.dumps(c['input'],ensure_ascii=False)[:90])
    if d.get('type')=='user':
        for c in d['message'].get('content',[]):
            if isinstance(c,dict) and c.get('type')=='tool_result':
                t=c['content'] if isinstance(c['content'],str) else json.dumps(c['content'],ensure_ascii=False)
                print('  result', ('ERR ' if c.get('is_error') else ''), t[:160].replace('\n',' '))
    if d.get('type')=='result': print('  final:', d.get('result','')[:220].replace('\n',' '))
