From: "Andy Younger" <andylyounger@hotmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Tue, 17 Apr 2001 09:01:00 -0000
Message-id: <F193ZcIVMm0LzEDYZqB0000cad7@hotmail.com>
X-SW-Source: 2001-q2/msg00102.html

>Should it not be a slow device being that calls to write() can block for a 
>good fraction of a second (depending on the size & number of fragments).

Sorry, don't know what I was thinking, It can infact block for much longer 
than this. It blocks for as long as the sample takes to play minus a small 
play ahead cache. Therefore a single write of a large sample (several megs), 
could take minutes to come back from the write().

Andy.
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com .
