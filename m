Return-Path: <cygwin-patches-return-3092-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1111 invoked by alias); 29 Oct 2002 15:09:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1031 invoked from network); 29 Oct 2002 15:09:04 -0000
Message-ID: <3DBEA46B.3090506@netscape.net>
Date: Tue, 29 Oct 2002 07:09:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Tishler <jason@tishler.net>
CC: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: export fseeko() and ftello() patch
References: <20021029141111.GA1812@tishler.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00043.txt.bz2

Jason Tishler wrote:
> The attached patch exports newlib's fseeko() and ftello().  Besides
> being generally useful, this patch also solves the first build issue in
> the following:
> 
>     http://archives.postgresql.org/pgsql-cygwin/2002-10/msg00039.php
> 
> Note that I would like to include a hunk for winsup/doc/calls.texinfo,
> but I don't know where to find the associated item information.  For
> example, where does one find the following?
> 
>     @item fseek: C 4.9.9.2, P 8.2.3.7
>                  ^^^^^^^^^  ^^^^^^^^^
> 

Yes, please do tell, because I have a few functions which 
are also SUSv2 compliant and I would like to know what 
numbering scheme means, too.

Cheers,
Nicholas

