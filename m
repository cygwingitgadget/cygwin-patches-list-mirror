Return-Path: <cygwin-patches-return-3746-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15711 invoked by alias); 26 Mar 2003 19:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15696 invoked from network); 26 Mar 2003 19:48:33 -0000
Message-ID: <3E820411.1020100@hekimian.com>
Date: Wed, 26 Mar 2003 19:48:00 -0000
X-Sybari-Trust: 5eb029f5 36b09be0 04609a3e 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris January <chris@atomice.net>
CC: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] performance patch for /proc/registry -- version 2
References: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net>
In-Reply-To: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00395.txt.bz2

Chris January wrote:

> How common are ACLs > 4096 bytes? Could you try calling RegKeyGetSecurity
> twice? First with a length of 0. Then RegKeyGetSecurity will set length to
> the required buffer size which you can allocate dynamically using new.

Whatever Corinna or Christopher want me to do is fine with me.  I just
copied some code from elsewhere in Cygwin.
-- 
Joe Buehler
