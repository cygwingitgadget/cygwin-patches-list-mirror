Return-Path: <cygwin-patches-return-4462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12336 invoked by alias); 1 Dec 2003 14:42:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12327 invoked from network); 1 Dec 2003 14:42:37 -0000
Message-ID: <3FCB5353.1040403@netscape.net>
Date: Mon, 01 Dec 2003 14:42:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
References: <87ad6cgb3m.fsf@vzell-de.de.oracle.com> <20031201102807.GB27760@cygbert.vinschen.de>
In-Reply-To: <20031201102807.GB27760@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00181.txt.bz2

cygwin-patches@cygwin.com wrote:
> On Mon, Dec 01, 2003 at 10:07:25AM +0100, Dr. Volker Zell wrote:
> 
>>Hi
>>
>>As discussed in cygwin-apps here's a small patch to point cygwin to an existing
>>time zone datasbase when the tzcode/data package is installed.
> 
> 
> Should we do some extra stuff to maintain backward compatibility with
> the old /usr/local/etc path?  I don't think so but...
>

As mentioned in another thread, in theory this should be an evironmental 
variable.  However, IIRC, I think DJ ripped out that portion of the 
code, probably assuming at the time there was no need for timezone data. 
  I'll go back and check, though.

Cheers,
Nicholas
