Return-Path: <cygwin-patches-return-6427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10703 invoked by alias); 3 Mar 2009 17:50:36 -0000
Received: (qmail 10692 invoked by uid 22791); 3 Mar 2009 17:50:36 -0000
X-SWARE-Spam-Status: No, hits=4.5 required=5.0 	tests=AWL,BARRACUDA_BRBL,BAYES_50,BOTNET,J_CHICKENPOX_36
X-Spam-Check-By: sourceware.org
Received: from vms173001pub.verizon.net (HELO vms173001pub.verizon.net) (206.46.173.1)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Mar 2009 17:50:30 +0000
Received: from PHUMBLETLAPXP ([216.75.130.148]) by vms173001.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KFX00084YVYHPF4@vms173001.mailsrvcs.net> for  cygwin-patches@cygwin.com; Tue, 03 Mar 2009 11:50:29 -0600 (CST)
Message-id: <0b1b01c99c28$8a2c6540$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>  <20090303153801.GA17180@ednor.casa.cgf.cx>
Subject: Re: [Patch] gethostbyname2  again
Date: Tue, 03 Mar 2009 17:50:00 -0000
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00025.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, March 03, 2009 10:38 AM
Subject: Re: [Patch] gethostbyname2 again


| On Mon, Mar 02, 2009 at 08:36:55PM -0500, Pierre A. Humblet wrote:
| >    realloc_ent function, and call it from both dup_ent and the helper. That 
| > caused minor
| >    changes in the 4 versions of dup_ent, and I don't know exactly what 
| > format to use in the ChangeLog
| 
| I would rather that you keep dup_ent as is so that there is no need to
| do run-time checks on the type.  If you need to do something similar to
| what is currently in dupent, then couldn't you still create a
| realloc_ent but just pass in the destination pointer?  Or even just make
| realloc_ent mimic realloc but do the rounding that seems to be the
| impetus for your breaking this out into a separate function.

Chris,

The impetus is that the new helper function is capable of formatting a fine
hostent in a single block of memory. So it doesn't need to have dup_ent
copy it in yet another memory block.

However it still needs to store a pointer to the block of memory somewhere,
so that it can be freed later, and reusing the tls.locals seems logical. If it does
that, then it must also free or realloc whatever is stored there.
That's what realloc_ent does.
The rounding is not essential, it's just nice to do it consistently in one place.

To avoid real-time checks, I could do as what dup_ent does, and have 4 versions
of the realloc_ent function, one main one with dst and sz arguments (that one
would be called by dup_ent without any  run-time checks) and 3 (actually only
1 is needed for now) that invoke the main one with the correct dst based on the
type of the src argument . The src argument would be null but would have the
right type! That seems to meet your wishes. OK?

Pierre


