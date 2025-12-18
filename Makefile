SYSCONFDIR ?= /etc
PREFIX ?= /usr

INSTALL ?= install
INSTALL_DIR = $(INSTALL) -d
INSTALL_FILE = $(INSTALL) -m 0644
INSTALL_EXEC = $(INSTALL) -m 0755

DESTDIR ?=

all:
	@echo "Nothing to build."

install:
	# /etc directories
	$(INSTALL_DIR) "$(DESTDIR)$(SYSCONFDIR)/profile.d"
	$(INSTALL_DIR) "$(DESTDIR)$(SYSCONFDIR)/ssh/sshd_config.d"
	$(INSTALL_DIR) "$(DESTDIR)$(SYSCONFDIR)/security/limits.d"

	$(INSTALL_DIR) "$(DESTDIR)$(PREFIX)/lib/sysctl.d"

	$(INSTALL_EXEC) "etc/profile.d/abyss-umask.sh" \
		"$(DESTDIR)$(SYSCONFDIR)/profile.d/abyss-umask.sh"

	$(INSTALL_FILE) "etc/ssh/sshd_config.d/00-abyss-baseline.conf" \
		"$(DESTDIR)$(SYSCONFDIR)/ssh/sshd_config.d/00-abyss-baseline.conf"

	$(INSTALL_FILE) "etc/security/limits.d/00-abyss-baseline.conf" \
		"$(DESTDIR)$(SYSCONFDIR)/security/limits.d/00-abyss-baseline.conf"

	$(INSTALL_FILE) "etc/abyss/firewall/base.nft" \
		"$(DESTDIR)$(SYSCONFDIR)/nftables.conf"

	$(INSTALL_FILE) "etc/sysctl.d/00-abyss-baseline.conf" \
		"$(DESTDIR)$(PREFIX)/lib/sysctl.d/00-abyss-baseline.conf"

uninstall:
	rm -f "$(SYSCONFDIR)/profile.d/abyss-umask.sh"
	rm -f "$(SYSCONFDIR)/ssh/sshd_config.d/00-abyss-baseline.conf"
	rm -f "$(SYSCONFDIR)/security/limits.d/00-abyss-baseline.conf"
	rm -f "$(SYSCONFDIR)/nftables.conf"
	rm -f "$(PREFIX)/lib/sysctl.d/00-abyss-baseline.conf"
