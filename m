Return-Path: <cygwin-patches-return-1495-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 23027 invoked by alias); 14 Nov 2001 19:41:32 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 23012 invoked from network); 14 Nov 2001 19:41:31 -0000
Date: Thu, 11 Oct 2001 10:28:00 -0000
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - change to not ask root on download only.
X-Mailer: Virtual Access by Atlantic Coast PLC, http://www.atlantic-coast.com/va
Message-Id: <VA.000009dc.00a69973@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
In-Reply-To: <01ee01c16c9e$0350bce0$0200a8c0@lifelesswks>
References: <VA.000009d7.011e66c9@thesoftwaresource.com> <01ee01c16c9e$0350bce0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00027.txt.bz2

Robert Collins wrote:
> can you generate patches with "-up" ? (See the cygwin contributors
> page).
> It makes it a lot easier to visually grok a patch.

I can do that.  Actually I knew I had done it two ways in the past and couldn't 
remember the other.  Nor was I sure which was the preferred - now I know.

> I'll update this for you to the io_streams code for HEAD committing.

Did it make it in the version you just rolled to the web page.

> Lastly, you were missing a call to get_root_dir_now which resulted in
> /etc/setup/last-cache never getting read.

Hum,  I'll have to look at the change you made - I thought mine was reading 
either file depending on where it found it. Ah well.  Thanks for correcting it 
anyways.



