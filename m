Return-Path: <cygwin-patches-return-2896-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31828 invoked by alias); 30 Aug 2002 17:57:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31810 invoked from network); 30 Aug 2002 17:57:39 -0000
Date: Fri, 30 Aug 2002 10:57:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <5199249725.20020830215547@logos-m.ru>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: [franck.leray@cheops.fr: tcsetattr timeout problem ?]
In-Reply-To: <136198673817.20020830214611@logos-m.ru>
References: <20020830145541.GB1402@redhat.com>
 <136198673817.20020830214611@logos-m.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00344.txt.bz2

Hi!

Friday, 30 August, 2002 egor duda deo@logos-m.ru wrote:

ed> Hi!

ed> Friday, 30 August, 2002 Christopher Faylor cgf@redhat.com wrote:

CF>> So, did you put someone up to this, Egor?  :-)

ed> Patch attached. Checking vtime in ready_for_read doesn't look like a
ed> best way to do this, but it seems to work.

Actually, the patch is wrong :(. I'm looking into it and post a
correct one asap.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
