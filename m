Return-Path: <cygwin-patches-return-3620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16759 invoked by alias); 22 Feb 2003 20:44:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16750 invoked from network); 22 Feb 2003 20:44:11 -0000
Date: Sat, 22 Feb 2003 20:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: syslog
Message-ID: <20030222204430.GD10871@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com> <3.0.5.32.20030221233251.007fb4f0@mail.attbi.com> <3.0.5.32.20030222151301.007fa530@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030222151301.007fa530@incoming.verizon.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00269.txt.bz2

On Sat, Feb 22, 2003 at 03:13:01PM -0500, Pierre A. Humblet wrote:
>At 02:35 PM 2/22/2003 -0500, Christopher Faylor wrote:
>>Applied with one minor change.  I shortened "Cygwin PID = %u" to just "PID
>%u"
>
>Hmm, I had another look while resolving the conflict and now I wonder
>        fputc ('\n', fp);
>        UnlockFile (fHandle, 0, 0, 1, 0);
>        if (ferror (fp))
>          debug_printf ("error in writing syslog");
>        fclose (fp);
>Shouldn't we fflush before the Unlock, or better remove the
>Unlock altogether? The line is probably still sitting in the 
>stream buffer and Windows won't see a write until the file
>is closed.

That sounds correct.  Feel free to check in a patch for this.  Any improvements
to syslog are welcome.

cgf
