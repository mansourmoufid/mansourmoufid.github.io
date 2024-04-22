import iptcinfo3

meta = {
    'images/mansourmoufid.jpg': {
        'caption/abstract': 'Photo of Mansour Moufid',
        'copyright notice': 'Copyright 2024 Mansour Moufid',
        'credit': 'Mansour Moufid',
        'source': 'Mansour Moufid',
    },
}

for image in meta:
    info = iptcinfo3.IPTCInfo(image, force=True)
    for x in meta[image]:
        info[x] = meta[image][x].encode()
    print(info)
    info.save()
