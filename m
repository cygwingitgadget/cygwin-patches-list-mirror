Return-Path: <cygwin-patches-return-3431-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29069 invoked by alias); 21 Jan 2003 15:34:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29050 invoked from network); 21 Jan 2003 15:34:19 -0000
Date: Tue, 21 Jan 2003 15:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Races in group/passwd code (was Re: etc_changed, passwd & group)
Message-ID: <20030121153538.GA24356@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121051325.GA4667@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00080.txt.bz2

After consolidating all of the lock code into a "refresh" method,
I realized that there are some pretty big races in the group/passwd
code.  You can't just protect the reading of the buffers against
multiple access, you have to protect all operations which manipulate
the passwd/group buffers since they could be changed out from under
you otherwise.

So, I will have another revamp coming shortly.

cgf
