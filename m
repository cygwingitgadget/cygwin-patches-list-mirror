Return-Path: <cygwin-patches-return-3619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9734 invoked by alias); 22 Feb 2003 20:13:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9724 invoked from network); 22 Feb 2003 20:13:46 -0000
Message-Id: <3.0.5.32.20030222151301.007fa530@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sat, 22 Feb 2003 20:13:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: syslog
In-Reply-To: <20030222193516.GB10871@redhat.com>
References: <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com>
 <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00268.txt.bz2

At 02:35 PM 2/22/2003 -0500, Christopher Faylor wrote:
>Applied with one minor change.  I shortened "Cygwin PID = %u" to just "PID
%u"

Hmm, I had another look while resolving the conflict and now I wonder
        fputc ('\n', fp);
        UnlockFile (fHandle, 0, 0, 1, 0);
        if (ferror (fp))
          debug_printf ("error in writing syslog");
        fclose (fp);
Shouldn't we fflush before the Unlock, or better remove the
Unlock altogether? The line is probably still sitting in the 
stream buffer and Windows won't see a write until the file
is closed.

Pierre
  
