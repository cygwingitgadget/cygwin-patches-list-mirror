From: Jonathan Kamens <jik@curl.com>
To: cygwin-patches@cygwin.com
Subject: A few fixes to winsup/utils/cygpath.cc
Date: Wed, 26 Dec 2001 05:03:00 -0000
Message-ID: <20011226130350.7718.qmail@lizard.curl.com>
X-SW-Source: 2001-q4/msg00353.html
Message-ID: <20011226050300.-Foj-ErFi3dPAYRisWGwti1vKJJE5p-zE2SbkIO88SE@z>

I sent this patch in last night, but I don't think it made it to the
list because I wasn't subscribed properly (at least, it's not in the
archive yet, and I assume it would have shown up by now), so here it
is again.

The patch below fixes the following three problems in
winsup/utils/cygpath.cc:

1) Calculate prog_name correctly -- skip over the final slash or
   backslash.
2) Print a useful error message and exit with non-zero status if the
   user tries to convert an empty path.
3) Detect if a path conversion function returns -1 (indicating
   failure) and print an error message if so.

jik
