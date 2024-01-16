#!/usr/bin/env python3

import argparse
import jinja2

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
# Running the Jinja2 magic for the CSV
#template_file_name = "clusterserviceversion.yaml.j2"
#template_file_path = os.path.join(script_path, template_file_name)
#rendered_file_name = f"{d}/kernel-module-management.{render_vars['release_version']}.clusterserviceversion.yaml"
#rendered_file_path = os.path.join(script_path, rendered_file_name)

environment = jinja2.Environment(loader=jinja2.FileSystemLoader("."))
output_text = environment.get_template(template_file_name).render(render_vars)

with open(rendered_file_name, "w") as output_file:
    output_file.write(output_text)


