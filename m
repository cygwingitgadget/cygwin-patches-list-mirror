Return-Path: <cygwin-patches-return-4034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5560 invoked by alias); 2 Aug 2003 16:11:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5549 invoked from network); 2 Aug 2003 16:11:18 -0000
Date: Sat, 02 Aug 2003 16:11:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
References: <20030802141248.GB16831@redhat.com>
Subject: Re: [PATCH] patch.cc: cygdrive_getmntent () - Unify behaviour with fhandler_cygdrive
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014308112@gmx.net
X-Authenticated-IP: [195.27.52.137]
Message-ID: <13970.1059840677@www56.gmx.net>
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q3/txt/msg00050.txt.bz2

> On Sat, Aug 02, 2003 at 01:53:21PM +0200, Pavel Tsekov wrote:
> >Here is a simple patch which makes the behaviour of getmntent ()
> >consistent with the one of fhandler_cygdrive.
> 
> The reason this is there is to avoid long delays in mount table
> listings.

Well, I guessed so, but it would be more convinient and consistent if
calling getmntent() could
retrieve all the accesible (mounted) drives. Anyway, I guess i'll be using
readdir () :)

Pavel

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post
