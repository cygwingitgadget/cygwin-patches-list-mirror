Return-Path: <cygwin-patches-return-2670-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16443 invoked by alias); 19 Jul 2002 12:35:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16386 invoked from network); 19 Jul 2002 12:35:27 -0000
Message-ID: <3D38078A.2090409@netscape.net>
Date: Fri, 19 Jul 2002 05:35:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
References: <F1338UJj1Nsjw6u1qzW00015e7e@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00118.txt.bz2

Andy Younger wrote:

> I stopped work on /dev/dsp as I did not require it to do any more. I 
> have a couple of outstanding patches to apply (a compatibility fix or 
> 2 and some work in decreasing latency (fixes Rocks & Diamonds)). I 
> will see about sorting them out.
>
> Read / Write support would be cool, as would /dev/mixer support if 
> your feeling brave :-)

Ditto from me.  The only reason I ask Jacek is that I have been working 
closely with the NASd author to make a fully-native cygwin port (w/ 
shared libraries).  Anyhow, the server is usually duplex in nature as 
opposed to simplex.  So, I asked Jacek b/c I thought he might know.

P.S. - Thanks again to Jacek for his serial patch!  Hopefully it will be 
applied to the sources soon :-).
