Return-Path: <cygwin-patches-return-4336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3845 invoked by alias); 3 Nov 2003 07:35:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3833 invoked from network); 3 Nov 2003 07:35:42 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3FA60530.6080204@gmx.net>
Date: Mon, 03 Nov 2003 07:35:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suspend all thread on SIGSTOP
References: <3FA2D171.6080806@gmx.net> <20031031212656.GB8668@redhat.com>
In-Reply-To: <20031031212656.GB8668@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00055.txt.bz2

Christopher Faylor wrote:
> On Fri, Oct 31, 2003 at 10:17:37PM +0100, Thomas Pfaff wrote:
> 
>>This time with attachment.
>>
>>This patch suspends all threads on SIGSTOP and resumes them on SIGCONT. 
>>The corresponding functions in the pthread class are already committed.
>>
>>Thomas
>>
>>2003-10-31  Thomas Pfaff  <tpfaff@gmx.net>
>>
>>	* exceptions.cc (sig_handle_tty_stop): Suspend all
>>	threads on SIGSTOP, resume them on SIGCONT.
> 
> 
> You can't suspend threads like this because SuspendThread can
> hang in some situations, like when a thread is doing I/O.  That's why
> there is a WaitForSingleObject here rather than just suspending the
> thread.

Too bad.

Thomas
