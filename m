Return-Path: <cygwin-patches-return-4331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19542 invoked by alias); 31 Oct 2003 20:57:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19531 invoked from network); 31 Oct 2003 20:57:17 -0000
Message-ID: <3FA2CCA8.2010703@gmx.net>
Date: Fri, 31 Oct 2003 20:57:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] suspend all thread on SIGSTOP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00050.txt.bz2

This patch suspends all threads on SIGSTOP and resumes them on SIGCONT. 
The corresponding functions in the pthread class are already committed.

Thomas

2003-10-31  Thomas Pfaff  <tpfaff@gmx.net>

	* exceptions.cc (sig_handle_tty_stop): Suspend all
	threads on SIGSTOP, resume them on SIGCONT.

