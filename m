From: DJ Delorie <dj@delorie.com>
To: juliano@cs.unc.edu
Cc: cygwin-patches@sources.redhat.com
Subject: Re: fix: setup.exe crash when "Nothing to Install/Update"
Date: Thu, 07 Sep 2000 08:43:00 -0000
Message-id: <200009071542.LAA08999@envy.delorie.com>
References: <1919463230.968287104@dsl-64-34-95-237.telocity.com>
X-SW-Source: 2000-q3/msg00075.html

Applied.  Thanks!

> 2000-09-07  Jeffrey Juliano  <juliano@cs.unc.edu>
> 
> 	* choose.cc (list_click): Check for nindexes==0; if so, return.
