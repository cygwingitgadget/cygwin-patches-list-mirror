Return-Path: <cygwin-patches-return-7968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9072 invoked by alias); 9 Feb 2014 12:37:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9053 invoked by uid 89); 9 Feb 2014 12:36:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout06.bt.lon5.cpcloud.co.uk
Received: from smtpout06.bt.lon5.cpcloud.co.uk (HELO smtpout06.bt.lon5.cpcloud.co.uk) (65.20.0.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2014 12:36:58 +0000
X-CTCH-RefID: str=0001.0A090208.52F77667.0115,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=7/97,refid=2.7.2:2014.2.8.223914:17:7.944,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, __CTE, __ANY_URI, __URI_NO_MAILTO, __CP_URI_IN_BODY, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODY_SIZE_700_799, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_1000_LESS, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.174.32.243) by smtpout06.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 52F0E43800508603 for cygwin-patches@cygwin.com; Sun, 9 Feb 2014 12:36:55 +0000
Message-ID: <52F77673.4090907@dronecode.org.uk>
Date: Sun, 09 Feb 2014 12:37:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Add minidump write utility
References: <52F50B71.8030608@dronecode.org.uk> <52F51450.7010601@dancol.org>
In-Reply-To: <52F51450.7010601@dancol.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-SW-Source: 2014-q1/txt/msg00041.txt.bz2

On 07/02/2014 17:13, Daniel Colascione wrote:
> May I recommend setting MiniDumpWithHandleData | MiniDumpWithFullMemoryInfo |
> MiniDumpWithThreadInfo | MiniDumpWithFullAuxiliaryState |
> MiniDumpIgnoreInaccessibleMemory | MiniDumpWithTokenInformation |
> MiniDumpWithModuleHeaders | MiniDumpWithIndirectlyReferencedMemory by default?

This seems sensible, but I can't see a clear statement that it's safe to
assume that MiniDumpWriteDump() ignores dump type flags it doesn't understand,
so it might be necessary to check the version of dbghelp.dll as well.

Originally, I was thinking of adding some named dump levels, like those
described at [1], but that hasn't happened yet.

[1] http://www.debuginfo.com/articles/effminidumps2.html#strategies
