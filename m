Return-Path: <cygwin-patches-return-3462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18749 invoked by alias); 24 Jan 2003 15:51:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18731 invoked from network); 24 Jan 2003 15:51:53 -0000
Date: Fri, 24 Jan 2003 15:51:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: nanosleep() patch
In-reply-to: <20030122104402.GB29236@cygbert.vinschen.de>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030124155815.GD612@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_nJvSYPbdKD+zjQPkK75ZoA)"
User-Agent: Mutt/1.4i
References: <20030117192853.GA1164@tishler.net>
 <20030121155842.GS29236@cygbert.vinschen.de>
 <20030121160201.GA13579@redhat.com>
 <20030121161706.GU29236@cygbert.vinschen.de>
 <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com>
 <20030121211649.GA2060@tishler.net> <20030121213341.GA952@tishler.net>
 <20030121214016.GA19951@redhat.com>
 <20030122104402.GB29236@cygbert.vinschen.de>
X-SW-Source: 2003-q1/txt/msg00111.txt.bz2


--Boundary_(ID_nJvSYPbdKD+zjQPkK75ZoA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 414

On Wed, Jan 22, 2003 at 11:44:02AM +0100, Corinna Vinschen wrote:
> I like that patch.  Applied.

I just realized that nanosleep() is not getting declared.  Is the
attached patch the best solution?  If so, then I will submit a patch to
newlib.  If not, what is?

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_nJvSYPbdKD+zjQPkK75ZoA)
Content-type: text/plain; charset=us-ascii; NAME=features.h.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=features.h.diff
Content-length: 555

Index: features.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/features.h,v
retrieving revision 1.5
diff -u -p -r1.5 features.h
--- features.h	20 Jun 2002 19:51:24 -0000	1.5
+++ features.h	24 Jan 2003 15:38:44 -0000
@@ -87,6 +87,7 @@ extern "C" {
 # define _POSIX_THREAD_PRIORITY_SCHEDULING       1
 # define _POSIX_THREAD_ATTR_STACKSIZE            1
 # define _POSIX_SEMAPHORES                       1
+#define _POSIX_TIMERS                            1
 #endif
 
 #ifdef __cplusplus

--Boundary_(ID_nJvSYPbdKD+zjQPkK75ZoA)--
