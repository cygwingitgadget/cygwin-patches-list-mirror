Return-Path: <cygwin-patches-return-3384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16845 invoked by alias); 14 Jan 2003 01:48:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16834 invoked from network); 14 Jan 2003 01:48:49 -0000
Message-ID: <3E236D49.2030506@21cn.com>
Date: Tue, 14 Jan 2003 01:48:00 -0000
From: David Huang <hzhr@21cn.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.2.1) Gecko/20021130
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: fhandler_dsp.cc (fhandler_dev_dsp::ioctl): add SNDCTL_DSP_GETFMTS
 support
Content-Type: multipart/mixed;
 boundary="------------080005040102010006070606"
X-SW-Source: 2003-q1/txt/msg00033.txt.bz2

This is a multi-part message in MIME format.
--------------080005040102010006070606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 589

Make code like this work:

	/* Get a list of supported hardware formats */
	if ( ioctl(audio_fd, SNDCTL_DSP_GETFMTS, &value) < 0 ) {
		SDL_SetError("Couldn't get audio format list");
		return(-1);
	}
(from SDL-1.2.5/src/audio/dsp/SDL_dspaudio.c, yes, seems like *Native* cygwin libSDL works)


I don't know exactly which hardware formats can the /dev/dsp audio device support,
but looks like it supports AFMT_S16_LE, AFMT_U8 and AFMT_S8.

Thanks.


2003-01-14  David Huang  <davehzhr@hotmail.com>

	* fhandler_dsp.cc (fhandler_dsp::ioctl): Add SNDCTL_DSP_GETFMTS
	limited support.









--------------080005040102010006070606
Content-Type: text/plain;
 name="fhandler_dsp.cc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fhandler_dsp.cc.patch"
Content-length: 635

Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.23
diff -u -p -r1.23 fhandler_dsp.cc
--- fhandler_dsp.cc	14 Dec 2002 04:01:32 -0000	1.23
+++ fhandler_dsp.cc	14 Jan 2003 01:30:01 -0000
@@ -623,6 +623,14 @@ fhandler_dev_dsp::ioctl (unsigned int cm
       }
       break;
 
+      CASE (SNDCTL_DSP_GETFMTS)
+      {
+        *intptr = AFMT_S16_LE | AFMT_U8 | AFMT_S8; // more?
+
+        return 0;
+      }
+      break;
+
     default:
       debug_printf ("/dev/dsp: ioctl not handled yet! FIXME:");
       break;



--------------080005040102010006070606--
