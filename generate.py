import os
import string
import sys


substitutions = {
    'origin': os.environ['ORIGIN'],
    'email': os.environ['EMAIL'],

    'common_style': 'src/common-style.html.in',
    'footer': 'src/footer.html.in',
    'nav': 'src/nav.html.in',
    'nav_style': 'src/nav-style.html.in',
    'cc_by_nc_sa': 'src/cc-by-nc-sa.html.in',
    'byline': 'src/byline.html.in',
    'analytics': 'src/analytics.html.in',
}

for line in sys.stdin:
    s = line.rstrip('\n')
    for sub in substitutions:
        template = string.Template(s)
        if os.path.exists(substitutions[sub]):
            with open(substitutions[sub], 'rt') as f:
                contents = f.read()
        else:
            contents = substitutions[sub]
        s = template.safe_substitute({sub: contents})
    print(s)
