Return-Path: <cygwin-patches-return-3593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2698 invoked by alias); 19 Feb 2003 01:12:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2637 invoked from network); 19 Feb 2003 01:12:34 -0000
Message-ID: <000701c2d7b3$fbed0e90$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Vaclav Haisman" <V.Haisman@sh.cvut.cz>,
	<cygwin-patches@cygwin.com>
References: <20030219013337.V52168-100000@logout.sh.cvut.cz>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Wed, 19 Feb 2003 01:12:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00242.txt.bz2

Vaclav Haisman wrote:
>> Could you do some tests, so we have more than conjecture to go on?
>>
>> What programs actually *benefit* from sparseness?
>
> My primary motivation to do this is that I use P2P sharing program
> called BitTorrent. This program is written in Python and I run it in
> Cygwin. This program first creates whole file that I want to download
> by writing very few bytes with long distances between them and then
> fills it as it downloads chunks of the file from various other peers.
> The creation of this file takes from tens of seconds to few minutes
> without this patch, depending on size of the file. But with this
> patch it takes about two seconds to create this almost empty file.
> The files I usually download are movies. I don't experience any extra
> slowness while playing such created files.

Well, why not have BitTorrent set the file as sparse?

Why should Cygwin do this for *all* files? - if it was universally
advantageous, I would imagine it would be on by default in Windows.

Max.
