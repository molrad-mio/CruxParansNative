import os
from PIL import Image

app_icon_dir = "Sources/CruxParansPro/Assets.xcassets/AppIcon.appiconset"
os.makedirs(app_icon_dir, exist_ok=True)

img = Image.new('RGB', (1024, 1024), color = (73, 109, 137))
img.save(f"{app_icon_dir}/Icon-1024.png")

contents_json = """{
  "images" : [
    {
      "filename" : "Icon-1024.png",
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}"""

with open(f"{app_icon_dir}/Contents.json", "w") as f:
    f.write(contents_json)
