from gi.repository import Gio

# Check if xapp favorites exist:
schema_source =  Gio.SettingsSchemaSource.get_default()
if Gio.SettingsSchemaSource.lookup(schema_source, "org.x.apps.favorites", True):
    # Read out xapp favorites
    settings = Gio.Settings(schema_id="org.x.apps.favorites")
    list = settings.get_value("list")

    for l in list:
        l = l.replace("file://", "")
        l = l.split("::")[0]
        print(l)
