Return-Path: <cygwin-patches-return-3108-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32746 invoked by alias); 4 Nov 2002 02:13:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32531 invoked from network); 4 Nov 2002 02:13:45 -0000
Date: Sun, 03 Nov 2002 18:13:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty patch
Message-ID: <20021104021537.GB28851@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002701c28394$ce2fc1f0$0201a8c0@sos> <20021104003759.GA22976@redhat.com> <003c01c2839c$355bf130$0201a8c0@sos> <20021104011150.GA23246@redhat.com> <004501c283a2$0b263870$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004501c283a2$0b263870$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00059.txt.bz2

On Sun, Nov 03, 2002 at 08:32:29PM -0500, Sergey Okhapkin wrote:
>
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Sunday, November 03, 2002 8:11 PM
>Subject: Re: fhandler_tty patch
>
>
>> Ok.  I haven't looked closely at this code before.  I just am not sure
>> what use setting the size on a pty master would entail.  I wonder if it
>> is supposed to be propagated to the slave.  Also, isn't the master
>> supposed to be notified of size changes in the slave?
>
>No. Slave only gets the notification. From HP-UX manual page:

I don't mean SIGWINCH.  I thought the master was supposed to be able
to arbitrate slave window size requests somehow.

>> I'll apply the patch but I suspect that this is still not exactly right
>> wrt UNIX emulation.
>
>Cygwin is not exactly right UNIX emulation - the PID of init process != 1:-)

Yeah, I think I've heard someone mention that.

cgf
