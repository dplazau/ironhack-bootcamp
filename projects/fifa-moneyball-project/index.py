from src.controllers.Configuration import load_conf_file

config_data = load_conf_file()
print(config_data)
print(config_data.get("data-storage-folder"))