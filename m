Return-Path: <cygwin-patches-return-7794-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31565 invoked by alias); 12 Jan 2013 16:57:12 -0000
Received: (qmail 31554 invoked by uid 22791); 12 Jan 2013 16:57:11 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,RDNS_NONE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from Unknown (HELO moutng.kundenserver.de) (212.227.17.10)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 12 Jan 2013 16:57:06 +0000
Received: from [127.0.0.1] (dslb-088-073-034-096.pools.arcor-ip.net [88.73.34.96])	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)	id 0M4B8t-1T3Tnl39BD-00rCFr; Sat, 12 Jan 2013 17:56:59 +0100
Message-ID: <50F195D9.7030904@towo.net>
Date: Sat, 12 Jan 2013 16:57:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Console modes: cursor style
References: <50EFCE3C.8030607@towo.net> <20130111110534.GD17162@calimero.vinschen.de> <50F00AFA.2000307@towo.net> <20130111133451.GH17162@calimero.vinschen.de>
In-Reply-To: <20130111133451.GH17162@calimero.vinschen.de>
X-TagToolbar-Keys: D20130112175657123
Content-Type: multipart/mixed; boundary="------------050705090400030300040408"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00005.txt.bz2

This is a multi-part message in MIME format.
--------------050705090400030300040408
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 853

Am 11.01.2013 14:34, schrieb Corinna Vinschen:
> On Jan 11 13:52, Thomas Wolff wrote:
>> On 11.01.2013 12:05, Corinna Vinschen wrote:
>>> On Jan 11 09:33, Thomas Wolff wrote:
>>>> The attached patch adds two escape control sequences to the Cygwin Console:
>>>>
>>>>   * Show/Hide Cursor (DECTCEM)
>>>>   * Set cursor style (DECSCUSR): block vs. underline cursor, or
>>>>     arbitrary size (as an extension, using values > 4)
>>>>
>>>> Thomas
>>>>
>>>> 2013-01-13  Thomas Wolff  <...>
>>>>
>>>> 	* fhandler.h (class dev_console): Flag for expanded control sequence.
>>>> 	* fhandler_console.cc (char_command): Supporting cursor style modes.
>>> Patch applied.  Can you provide a patch for the docs, too, please?
>> Sure, but: where are the docs to be patched? Any package to be installed?
> Cygwin CVS, file winsup/doc/new-features.sgml
Patch attached.

--------------050705090400030300040408
Content-Type: text/plain; charset=windows-1252;
 name="cursor.doc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cursor.doc.patch"
Content-length: 1184

LS0tIHNhdi9uZXctZmVhdHVyZXMuc2dtbAkyMDEyLTEyLTE1IDE4OjQyOjE4
LjAwMDAwMDAwMCArMDEwMAorKysgLi9uZXctZmVhdHVyZXMuc2dtbAkyMDEz
LTAxLTExIDE0OjUzOjIyLjA2MzgxNDEwMCArMDEwMApAQCAtNCw2ICs0LDI1
IEBACiAKIDxpdGVtaXplZGxpc3QgbWFyaz0iYnVsbGV0Ij4KIAorPGxpc3Rp
dGVtPjxwYXJhPkFkZGVkIFdpbmRvd3MgY29uc29sZSBjdXJzb3IgYXBwZWFy
YW5jZSBzdXBwb3J0LjwvcGFyYT4KKworICA8aXRlbWl6ZWRsaXN0IG1hcms9
ImJ1bGxldCI+CisKKyAgPGxpc3RpdGVtPjxwYXJhPgorICBTaG93L0hpZGUg
Q3Vyc29yIG1vZGUgKERFQ1RDRU0pOiAiRVNDWz8yNWgiIC8gIkVTQ1s/MjVs
IgorICA8L3BhcmE+PC9saXN0aXRlbT4KKworICA8bGlzdGl0ZW0+PHBhcmE+
CisgIFNldCBjdXJzb3Igc3R5bGUgKERFQ1NDVVNSKTogIkVTQ1tuIHEiIChu
b3RlIHRoZSBzcGFjZSBiZWZvcmUgdGhlIHEpOworICB3aGVyZSBuIGlzIDAs
IDEsIDIgZm9yIGJsb2NrIGN1cnNvciwgMywgNCBmb3IgdW5kZXJsaW5lIGN1
cnNvciAoYWxsIAorICBkaXNyZWdhcmRpbmcgYmxpbmtpbmcgbW9kZSksIG9y
ID4gNCB0byBzZXQgdGhlIGN1cnNvciBoZWlnaHQgdG8gYSAKKyAgcGVyY2Vu
dGFnZSBvZiB0aGUgY2VsbCBoZWlnaHQuCisgIDwvcGFyYT48L2xpc3RpdGVt
PgorCisgIDwvaXRlbWl6ZWRsaXN0PgorCis8L2xpc3RpdGVtPgorCiA8bGlz
dGl0ZW0+PHBhcmE+CiBGb3IgcGVyZm9ybWFuY2UgcmVhc29ucywgQ3lnd2lu
IGRvZXMgbm90IHRyeSB0byBjcmVhdGUgc3BhcnNlIGZpbGVzCiBhdXRvbWF0
aWNhbGx5IGFueW1vcmUsIHVubGVzcyB5b3UgdXNlIHRoZSBuZXcgInNwYXJz
ZSIgbW91bnQgb3B0aW9uLgo=

--------------050705090400030300040408--
