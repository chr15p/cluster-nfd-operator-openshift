#!/usr/bin/env python3

import argparse
#import jinja2
import re

render_vars = {}

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--template", help="template to render")
parser.add_argument("-r", "--render", help="filename of rendered file")
parser.add_argument('params', nargs=argparse.REMAINDER)
args = parser.parse_args()

template_file_name = args.template
rendered_file_name = args.render

for i in args.params:
    k,v = i.split("=")
    render_vars[k] = v

print(render_vars)


with open(template_file_name) as file:
    contents = file.read()

    for k,v in render_vars.items():
        #parts = v.split(":")
        print(f"k={k}, v={v}")
        print(k+"@sha256:[0-9A-Fa-f]{65}")
        contents = re.sub(r"" +k+"@sha256:[0-9A-Fa-f]+", v, contents)

#print(contents)
# Running the Jinja2 magic for the CSV
#template_file_name = "clusterserviceversion.yaml.j2"
#template_file_path = os.path.join(script_path, template_file_name)
#rendered_file_name = f"{d}/kernel-module-management.{render_vars['release_version']}.clusterserviceversion.yaml"
#rendered_file_path = os.path.join(script_path, rendered_file_name)

#environment = jinja2.Environment(loader=jinja2.FileSystemLoader("."))
#output_text = environment.get_template(template_file_name).render(render_vars)
#


with open(rendered_file_name, "w") as output_file:
    output_file.write(contents)


