COQC ?= rocq compile

CORE = MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core
PROOF = EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof

.PHONY: all clean

all: $(PROOF).vo

$(CORE).vo: $(CORE).v
	$(COQC) $<

$(PROOF).vo: $(PROOF).v $(CORE).vo
	$(COQC) $<

clean:
	rm -f *.vo *.vos *.vok *.glob .*.aux
