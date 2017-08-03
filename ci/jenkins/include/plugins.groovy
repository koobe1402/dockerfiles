import jenkins.model.*
import java.util.logging.Logger
def logger = Logger.getLogger("")
def installed = false
def initialized = false

def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()

new File('/var/lib/jenkins/plugins_to_install').eachLine { line ->
  if (!pm.getPlugin(line)) {
    logger.info("Checking " + line)
    if (!initialized) {
      uc.updateAllSites()
      initialized = true
    }

    def plugin = uc.getPlugin(line)
    if (plugin) {
      logger.info("Installing " + line)
      def installFuture = plugin.deploy()
      while(!installFuture.isDone()) {
        logger.info("Waiting for plugin install: " + line)
        sleep(3000)
      }
      installed = true
    }
  }
}
if (installed) {
  logger.info("Plugins installed, initializing a restart!")
  instance.save()
  instance.restart()
}
