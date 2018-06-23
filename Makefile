# See LICENSE for licensing info$(RM) ation.
DEPS_PLT := $(CURDIR)/_build/.deps_plt

ERLANG_DIALYZER_APPS := erts \
						kernel \
						stdlib \
						inets
ELVIS := ./deps/elvis_shell/ebin/elvis
MIX := /usr/local/bin/mix
DIALYZER := $(MIX) dialyzer
DEPS_GET := $(MIX) deps.get
DEPS_UPDATE := $(MIX) deps.get
DEPS_COMPILE := $(MIX) deps.compile --all

# Clean
.PHONY: clean
clean:
	$(RM) -r .rebar
	$(RM) -r .mix
	$(RM) -r .cache
	$(RM) -r _build
	$(RM) -r bin
	$(RM) doc/*.html
	$(RM) doc/edoc-info
	$(RM) doc/erlang.png
	$(RM) doc/stylesheet.css
	$(RM) -r ebin
	$(RM) -r logs

.PHONY: distclean
distclean:
	$(RM) $(DEPS_PLT)
	$(RM) -r deps
	$(MAKE) clean

# Docs

.PHONY: docs
docs: $(MIX) doc skip_deps=true


# Tests.
.PHONY: eunit
eunit:
	$(MIX) eunit skip_deps=true

.PHONY: ct
ct:
	$(MIX) ct skip_deps=true suites="jesse_tests_draft3,jesse_tests_draft4"

.PHONY: xref
xref:
	$(MIX) xref skip_deps=true

$(DEPS_PLT):
	$(DIALYZER) --build_plt --apps $(ERLANG_DIALYZER_APPS) -r deps --output_plt $(DEPS_PLT)

.PHONY: dialyzer
dialyzer: $(MIX) dialyzer

.PHONY: elvis
elvis:
	$(ELVIS) rock > test/elvis
	grep "FAIL" test/elvis | sed "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" > test/elvis_warnings
	diff -U0 test/known_elvis_warnings test/elvis_warnings || cat test/elvis
