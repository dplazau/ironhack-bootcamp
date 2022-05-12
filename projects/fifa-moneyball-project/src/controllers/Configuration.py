import json

CONFIG_FILE = "./src/conf/index.json"

class ConfigurationController(object):
    class __ConfigurationController:
        def __init__(self):
            with open(CONFIG_FILE) as config_file:
                self.config_data = json.load(config_file)
                locals().update(self.config_data)

        def get(self, key):
            locals().update(self.config_data)
            return self.config_data[key]

    instance = None

    def __new__(cls):
        if not ConfigurationController.instance:
            ConfigurationController.instance = ConfigurationController.__ConfigurationController()
        return ConfigurationController.instance


def load_conf_file():
    obj = ConfigurationController()
    config = obj
    return config