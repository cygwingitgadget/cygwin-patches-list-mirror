Return-Path: <cygwin-patches-return-2634-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 909 invoked by alias); 11 Jul 2002 17:18:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 742 invoked from network); 11 Jul 2002 17:18:13 -0000
Message-ID: <3D2DBB3B.90209@netscape.net>
Date: Thu, 11 Jul 2002 10:18:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utils.sgml patch
References: <Pine.CYG.4.44.0207101914060.1316-200000@iocc.com> <20020711021919.GB17490@redhat.com> <6490-Thu11Jul2002124254+0100-starksb@ebi.ac.uk> <20020711140905.P24137@cygbert.vinschen.de> <20020711150222.GB7578@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00082.txt.bz2

Christopher Faylor wrote:

>On Thu, Jul 11, 2002 at 02:09:05PM +0200, Corinna Vinschen wrote:
>
>>On Thu, Jul 11, 2002 at 12:42:54PM +0100, David Starks-Browning wrote:
>>
>>>On Wednesday 10 Jul 02, Christopher Faylor writes:
>>>
>>>>Applied.  ta da!
>>>>
>>>>cgf
>>>>
>>>Thanks Joshua!
>>>
>>>With all these delightful utils.sgml patches, someone will have to
>>>update the online html docs.  I've never done that before, but I'll
>>>give it a go, hopefully in the next couple of days, if nobody beats me
>>>to it.
>>>
>>>Unless, Corinna, you want me to leave it alone.
>>>
>>Just go ahead!
>>
>
>I've regenerated this in the past but apparently my upgrade to RH Linux
>7.3 left me with some docbook tools that don't like cygwin.  This has
>always been an annoyance with our use of these tools.
>
>I wonder if the sgml files are a barrier to entry for documentation
>contributions.
>
>Anyway, if you can regenerate these files, it would be appreciated,
>David.
>
I'll tell you one thing, it was the biggest P.I.T.A. to get cygwin 
compatible docbook tools setup on both RHL7.3 and cygwin itself.  I do 
not reccomend it for those who do not want to waste an entire day.  You 
may be right in this deterring contributors.  Even after that, latex is 
*still* interpreting some tags strangely.  I'm afraid to contribute 
because I can't be sure my sgml syntax is going to work.  I'd reccomend 
popping over to the redhat docbook-utils maintainer's cubical and see 
what you can't stir up in terms of a decent set of packages for building 
the cygwin docs.  However, when you have it setup, db is the best method 
of creating documentation.  *Sigh*

Cheers,
Nicholas
