From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: setup.exe 2.53 fails when fetching source
Date: Wed, 16 May 2001 15:09:00 -0000
Message-id: <VA.0000077c.0168d8e4@thesoftwaresource.com>
References: <000801c0de47$c8dfd350$e333273f@ca.boeing.com>
X-SW-Source: 2001-q2/msg00254.html

Michael A. Chase wrote:
> When I try to fetch the latest bash source using the setup.exe I just built
> from the CVS tree, it aborts with a Dr Watson dump.  I haven't seen this
>
You must be trying to use either Reinstall, ReDownload or the Sources Only 
option.  I just tried ReDownload and Sources only and both are broken.  
Something in the last batch of cleanups we submitted broke these options.  
Haven't had a chance to backtrack yet. Sources Only reports wrong size and it 
is not even the correct size for the source I selected and Redownload Crashes 
big time on Win95.

Bk

