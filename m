From: Jonathan Kamens <jik@curl.com>
To: cygwin-patches@cygwin.com
Cc: cygwin-patches@cygwin.com
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Date: Wed, 26 Dec 2001 09:40:00 -0000
Message-ID: <20011226174012.23919.qmail@lizard.curl.com>
References: <20011226130350.7718.qmail@lizard.curl.com> <20011226173530.GB21023@redhat.com>
X-SW-Source: 2001-q4/msg00355.html
Message-ID: <20011226094000.RFNZCi_V194kfg8PBdr3yo5M4isPz_hn5ViVebh4ZTc@z>

2001-12-26  Jonathan Kamens  <jik@curl.com>

	* cygpath.cc (doit): Detect and warn about an empty path.  Detect
	and warn about errors converting a path.
	(main): Set prog_name correctly -- don't leave an extra slash or
	backslash at the beginning of it.
