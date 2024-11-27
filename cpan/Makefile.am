SUBDIRS = .

CPAN_DIST_MAKER=@MAKE_CPAN_DIST@

package_version=@PACKAGE_VERSION@

package=@PACKAGE@

scandeps=@SCANDEPS@

requires:
	set -e; dependencies=$$(mktemp); \
	test -x "$(scandeps)" || false; \
	for a in $$(find  $(top_srcdir) -type f \( -name '*.pm' -o -name '*.t' \) ); \
	  do $(scandeps) $(NO_CORE) -r $$a >>$$dependencies; \
	done; \
	cat $$dependencies | grep -v 'Amazon::' | awk '{ print $$1 " " $$2}' |sort -u >$@

# builds the distribution tarball and renames based on package version
cpan: buildspec.yml requires
	PROJECT_ROOT="--project-root $$(readlink -f ..)"; \
	$(CPAN_DIST_MAKER) $$PROJECT_ROOT -b $<

.PHONY: cpan

dist_noinst_DATA = buildspec.yml

clean-local:
	rm -f *.tar.gz
