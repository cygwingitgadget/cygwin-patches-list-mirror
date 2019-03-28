Return-Path: <cygwin-patches-return-9250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4340 invoked by alias); 28 Mar 2019 08:34:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4304 invoked by uid 89); 28 Mar 2019 08:34:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=cygwin64
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 08:34:43 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 09:34:09 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h9QUC-0001Fl-9E; Thu, 28 Mar 2019 09:34:08 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 08:34:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327091640.GE4096@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------0F70C0C93567A7FE0D77CACF"
X-SW-Source: 2019-q1/txt/msg00060.txt.bz2

This is a multi-part message in MIME format.
--------------0F70C0C93567A7FE0D77CACF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-length: 3977

Hi Corinna,

On 3/27/19 10:16 AM, Corinna Vinschen wrote:
> On Mar 27 09:26, Michael Haubenwallner wrote:
>> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
>>> On Mar 26 19:25, Corinna Vinschen wrote:
>>>> On Mar 26 18:10, Michael Haubenwallner wrote:
>>>>> Hi Corinna,
>>>>>
>>>>> as I do still encounter fork errors (address space needed by <dll> is
>>>>> already occupied) with dynamically loaded dlls (but unrelated to
>>>>> replaced dlls), one of them repeating even upon multiple retries,
>>>>
>>>> Why didn't rebase fix that?
>>
>> As far as I understand, rebasing is about touching already installed
>> dlls as well, which would require to restart all Cygwin processes.
>> As the problem is about some dll built during a larger build job,
>> this is not something that feels useful to me.
> 
> Wait, let me understand what's going on.  IIUC you're building DLLs
> which are then used during the build job itself, right?

Exactly.
FWIW, the CI builds also set up a Cygwin instance from scratch,
as I'm also after testing Cygwin (v3) itself to some degree:
https://dev.azure.com/gentoo-prefix/ci-builds/_build

However, I've not found a commandline option for setup.exe to install
"test" versions...

> 
>>> Btw., is that 32 or 64 bit?  Both?
>>
>> I'm on 64bit only, can't say for 32bit.  And while in theory possible,
>> I'm not after supporting 32bit Cygwin in Gento Prefix at all...
> 
> If so, then I'm really curious how many DLLs are affected and why this
> occurs on 64 bit.
> 
> As you know, 64 bit has a defined memory layout.  Binutils ld is
> supposed to base the DLLs to a pseudo-random address in the area between
> 0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased DLLs
> only.  8 Gigs is a *lot* of space for DLLs.
> 
> That also means that the DLLs should not at all collide with windows
> objects (typically reserved in the lesser 2 Gigs area), unless they
> collide with themselves.  At least that's the idea.
> 
> Can you check what addresses the freshly built DLLs are based on by LD?
> Is there a chance that the algorithm used in LD is too dumb?

I've also added system_printf to dll_list::reserve_space() when a dynloaded
dll was relocated, and each new address was below 0x0:01000000. The attached
output also contains the preferred address, above 0x4:00000000 each.

> 
> Or, hmm.  Is there a chance that newer Windows loads dynamically loaded
> DLLs whereever it likes, ignoring the base address, ASLR-like, even
> if the DLL is marked as non-ASLR-aware?  But then again, we should have
> a lot more complaints on the list...

I've done this test on Windows Server 2012R2, but the problem exists on
2016 and 2019 as well (I'm not testing with other Windows versions).

>>>>>  I'm
>>>>> coming up with attached patch.
>>>>>
>>>>> What do you think about it?
>>>>
>>>> I'm not opposed to this patch but I don't quite follow the description.
>>>> threadinterface->Init only creates three event objects.  From what I can
>>>> tell, Events are stored in Paged and Nonpaged Pools, so they don't
>>>> affect the processes VM.  What am I missing?
>>
>> Honestly, I'm not completely sure whether this patch really does help:
>> Beyond the Events, there also is CreateNamedPipe and CreateFile used
>> in fhandler_pipe::create via sigproc_init, and these causing the address
>> conflicts with some dll actually is nothing more than a wild guess:
>> While their returned handles are below the conflicting dll address,
>> who can tell what these API calls do allocate internally?
> 
> The handles are not addresses.  If the sigproc_init stuff collides,
> I only see two chances for that, the process-local read/write buffers
> of the signal pipe, and the stack of the read_sig thread.
> 
> If this patch helps your situation, we can pull it in and test it,
> but I think your situation asks for more debugging along the lines
> of the DLL rebasing above.

With this patch collisions seem gone, yet the relocations do happen.

Thanks!
/haubi/

--------------0F70C0C93567A7FE0D77CACF
Content-Type: text/plain; charset=UTF-8;
 name="relocated.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="relocated.out"
Content-length: 7292

ICAgICAyOSBbbWFpbl0gcHl0aG9uMi43IDUxMTEzIGRsbF9saXN0OjpyZXNl
cnZlX3NwYWNlOiBsaWJweXRob24yLjcuZGxsIHByZWZlcnJpbmcgMHg1M0JC
NTAwMDAgd2FzIGxvYWRlZCB0byAweEE4MDAwMCAoXD8/XEM6XGN5Z3dpbjY0
XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xnZW50b28tcHJlZml4XHZhclx0
bXBccG9ydGFnZVxkZXYtbGFuZ1xweXRob24tMi43LjE2XHdvcmtceDg2XzY0
LXBjLWN5Z3dpblxsaWJweXRob24yLjcuZGxsKQogICAgICAyIFttYWluXSBw
eXRob24yLjcgNTI1MjYgZGxsX2xpc3Q6OnJlc2VydmVfc3BhY2U6IGN5Z2Ny
eXB0by0xLjEuZGxsIHByZWZlcnJpbmcgMHg0MUM2NTAwMDAgd2FzIGxvYWRl
ZCB0byAweDY1MDAwMCAoXD8/XEM6XGN5Z3dpbjY0XGhvbWVcaGF1YmlcdGVz
dC0yMDE5MDMyN1xnZW50b28tcHJlZml4XHVzclxiaW5cY3lnY3J5cHRvLTEu
MS5kbGwpCiAgICAgIDIgW21haW5dIHB5dGhvbjIuNyA1NDM1MiBkbGxfbGlz
dDo6cmVzZXJ2ZV9zcGFjZTogY3lnY3J5cHRvLTEuMS5kbGwgcHJlZmVycmlu
ZyAweDQxQzY1MDAwMCB3YXMgbG9hZGVkIHRvIDB4NkUwMDAwIChcPz9cQzpc
Y3lnd2luNjRcaG9tZVxoYXViaVx0ZXN0LTIwMTkwMzI3XGdlbnRvby1wcmVm
aXhcdXNyXGJpblxjeWdjcnlwdG8tMS4xLmRsbCkKICAgICAgMiBbbWFpbl0g
cHl0aG9uMi43IDU1NzYwIGRsbF9saXN0OjpyZXNlcnZlX3NwYWNlOiBjeWdj
cnlwdG8tMS4xLmRsbCBwcmVmZXJyaW5nIDB4NDFDNjUwMDAwIHdhcyBsb2Fk
ZWQgdG8gMHg3QzAwMDAgKFw/P1xDOlxjeWd3aW42NFxob21lXGhhdWJpXHRl
c3QtMjAxOTAzMjdcZ2VudG9vLXByZWZpeFx1c3JcYmluXGN5Z2NyeXB0by0x
LjEuZGxsKQogICAgICAzIFttYWluXSBweXRob24yLjcgNTU3NjMgZGxsX2xp
c3Q6OnJlc2VydmVfc3BhY2U6IGN5Z2NyeXB0by0xLjEuZGxsIHByZWZlcnJp
bmcgMHg0MUM2NTAwMDAgd2FzIGxvYWRlZCB0byAweDdDMDAwMCAoXD8/XEM6
XGN5Z3dpbjY0XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xnZW50b28tcHJl
Zml4XHVzclxiaW5cY3lnY3J5cHRvLTEuMS5kbGwpCiAgICAgIDIgW21haW5d
IHB5dGhvbjIuNyA1NTc2NiBkbGxfbGlzdDo6cmVzZXJ2ZV9zcGFjZTogY3ln
Y3J5cHRvLTEuMS5kbGwgcHJlZmVycmluZyAweDQxQzY1MDAwMCB3YXMgbG9h
ZGVkIHRvIDB4N0MwMDAwIChcPz9cQzpcY3lnd2luNjRcaG9tZVxoYXViaVx0
ZXN0LTIwMTkwMzI3XGdlbnRvby1wcmVmaXhcdXNyXGJpblxjeWdjcnlwdG8t
MS4xLmRsbCkKICAgICAgMiBbbWFpbl0gcHl0aG9uMi43IDU1NzY5IGRsbF9s
aXN0OjpyZXNlcnZlX3NwYWNlOiBjeWdjcnlwdG8tMS4xLmRsbCBwcmVmZXJy
aW5nIDB4NDFDNjUwMDAwIHdhcyBsb2FkZWQgdG8gMHg3QzAwMDAgKFw/P1xD
OlxjeWd3aW42NFxob21lXGhhdWJpXHRlc3QtMjAxOTAzMjdcZ2VudG9vLXBy
ZWZpeFx1c3JcYmluXGN5Z2NyeXB0by0xLjEuZGxsKQogICAgICAyIFttYWlu
XSBweXRob24yLjcgNTYwNzkgZGxsX2xpc3Q6OnJlc2VydmVfc3BhY2U6IGN5
Z2NyeXB0by0xLjEuZGxsIHByZWZlcnJpbmcgMHg0MUM2NTAwMDAgd2FzIGxv
YWRlZCB0byAweDkwMDAwMCAoXD8/XEM6XGN5Z3dpbjY0XGhvbWVcaGF1Ymlc
dGVzdC0yMDE5MDMyN1xnZW50b28tcHJlZml4XHVzclxiaW5cY3lnY3J5cHRv
LTEuMS5kbGwpCiAgICAgIDIgW21haW5dIHB5dGhvbjIuNyA1NjA4MiBkbGxf
bGlzdDo6cmVzZXJ2ZV9zcGFjZTogY3lnY3J5cHRvLTEuMS5kbGwgcHJlZmVy
cmluZyAweDQxQzY1MDAwMCB3YXMgbG9hZGVkIHRvIDB4OTAwMDAwIChcPz9c
QzpcY3lnd2luNjRcaG9tZVxoYXViaVx0ZXN0LTIwMTkwMzI3XGdlbnRvby1w
cmVmaXhcdXNyXGJpblxjeWdjcnlwdG8tMS4xLmRsbCkKICAgICAgMyBbbWFp
bl0gcHl0aG9uMi43IDU2MDg1IGRsbF9saXN0OjpyZXNlcnZlX3NwYWNlOiBj
eWdjcnlwdG8tMS4xLmRsbCBwcmVmZXJyaW5nIDB4NDFDNjUwMDAwIHdhcyBs
b2FkZWQgdG8gMHg5MDAwMDAgKFw/P1xDOlxjeWd3aW42NFxob21lXGhhdWJp
XHRlc3QtMjAxOTAzMjdcZ2VudG9vLXByZWZpeFx1c3JcYmluXGN5Z2NyeXB0
by0xLjEuZGxsKQogICAgICAzIFttYWluXSBweXRob24yLjcgNTYwODggZGxs
X2xpc3Q6OnJlc2VydmVfc3BhY2U6IGN5Z2NyeXB0by0xLjEuZGxsIHByZWZl
cnJpbmcgMHg0MUM2NTAwMDAgd2FzIGxvYWRlZCB0byAweDkwMDAwMCAoXD8/
XEM6XGN5Z3dpbjY0XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xnZW50b28t
cHJlZml4XHVzclxiaW5cY3lnY3J5cHRvLTEuMS5kbGwpCiAgICAgIDIgW21h
aW5dIHB5dGhvbjIuNyA1NjA5MSBkbGxfbGlzdDo6cmVzZXJ2ZV9zcGFjZTog
Y3lnY3J5cHRvLTEuMS5kbGwgcHJlZmVycmluZyAweDQxQzY1MDAwMCB3YXMg
bG9hZGVkIHRvIDB4OTAwMDAwIChcPz9cQzpcY3lnd2luNjRcaG9tZVxoYXVi
aVx0ZXN0LTIwMTkwMzI3XGdlbnRvby1wcmVmaXhcdXNyXGJpblxjeWdjcnlw
dG8tMS4xLmRsbCkKICAgICAgMiBbbWFpbl0gcHl0aG9uMi43IDU5MjAxIGRs
bF9saXN0OjpyZXNlcnZlX3NwYWNlOiBjeWdjcnlwdG8tMS4xLmRsbCBwcmVm
ZXJyaW5nIDB4NDFDNjUwMDAwIHdhcyBsb2FkZWQgdG8gMHhDMTAwMDAgKFw/
P1xDOlxjeWd3aW42NFxob21lXGhhdWJpXHRlc3QtMjAxOTAzMjdcZ2VudG9v
LXByZWZpeFx1c3JcYmluXGN5Z2NyeXB0by0xLjEuZGxsKQogICAgICAzIFtt
YWluXSBweXRob24zLjZtIDU4MTAzIGRsbF9saXN0OjpyZXNlcnZlX3NwYWNl
OiBsaWJweXRob24zLjZtLmRsbCBwcmVmZXJyaW5nIDB4NDI4OEQwMDAwIHdh
cyBsb2FkZWQgdG8gMHhCMDAwMDAgKFw/P1xDOlxjeWd3aW42NFxob21lXGhh
dWJpXHRlc3QtMjAxOTAzMjdcZ2VudG9vLXByZWZpeFx2YXJcdG1wXHBvcnRh
Z2VcZGV2LWxhbmdccHl0aG9uLTMuNi44XHdvcmtcUHl0aG9uLTMuNi44XGxp
YnB5dGhvbjMuNm0uZGxsKQogICAgICA0IFttYWluXSBweXRob24yLjcgODg4
OSBkbGxfbGlzdDo6cmVzZXJ2ZV9zcGFjZTogY3lnY3J5cHRvLTEuMS5kbGwg
cHJlZmVycmluZyAweDQxQzY1MDAwMCB3YXMgbG9hZGVkIHRvIDB4NzMwMDAw
IChcPz9cQzpcY3lnd2luNjRcaG9tZVxoYXViaVx0ZXN0LTIwMTkwMzI3XGdl
bnRvby1wcmVmaXhcdXNyXGJpblxjeWdjcnlwdG8tMS4xLmRsbCkKICAgICAg
MiBbbWFpbl0gcHl0aG9uMi43IDEwMjA4IGRsbF9saXN0OjpyZXNlcnZlX3Nw
YWNlOiBjeWdjcnlwdG8tMS4xLmRsbCBwcmVmZXJyaW5nIDB4NDFDNjUwMDAw
IHdhcyBsb2FkZWQgdG8gMHg3MzAwMDAgKFw/P1xDOlxjeWd3aW42NFxob21l
XGhhdWJpXHRlc3QtMjAxOTAzMjdcZ2VudG9vLXByZWZpeFx1c3JcYmluXGN5
Z2NyeXB0by0xLjEuZGxsKQogICAgICAyIFttYWluXSBweXRob24yLjcgMTAy
MTEgZGxsX2xpc3Q6OnJlc2VydmVfc3BhY2U6IGN5Z2NyeXB0by0xLjEuZGxs
IHByZWZlcnJpbmcgMHg0MUM2NTAwMDAgd2FzIGxvYWRlZCB0byAweDczMDAw
MCAoXD8/XEM6XGN5Z3dpbjY0XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xn
ZW50b28tcHJlZml4XHVzclxiaW5cY3lnY3J5cHRvLTEuMS5kbGwpCiAgICAg
IDIgW21haW5dIHB5dGhvbjIuNyAxMDIxNCBkbGxfbGlzdDo6cmVzZXJ2ZV9z
cGFjZTogY3lnY3J5cHRvLTEuMS5kbGwgcHJlZmVycmluZyAweDQxQzY1MDAw
MCB3YXMgbG9hZGVkIHRvIDB4NzMwMDAwIChcPz9cQzpcY3lnd2luNjRcaG9t
ZVxoYXViaVx0ZXN0LTIwMTkwMzI3XGdlbnRvby1wcmVmaXhcdXNyXGJpblxj
eWdjcnlwdG8tMS4xLmRsbCkKICAgICAgMiBbbWFpbl0gcHl0aG9uMi43IDEw
MjE3IGRsbF9saXN0OjpyZXNlcnZlX3NwYWNlOiBjeWdjcnlwdG8tMS4xLmRs
bCBwcmVmZXJyaW5nIDB4NDFDNjUwMDAwIHdhcyBsb2FkZWQgdG8gMHg3MzAw
MDAgKFw/P1xDOlxjeWd3aW42NFxob21lXGhhdWJpXHRlc3QtMjAxOTAzMjdc
Z2VudG9vLXByZWZpeFx1c3JcYmluXGN5Z2NyeXB0by0xLjEuZGxsKQogICAg
ICAyIFttYWluXSBweXRob24yLjcgMTA0NjcgZGxsX2xpc3Q6OnJlc2VydmVf
c3BhY2U6IGN5Z2NyeXB0by0xLjEuZGxsIHByZWZlcnJpbmcgMHg0MUM2NTAw
MDAgd2FzIGxvYWRlZCB0byAweDc1MDAwMCAoXD8/XEM6XGN5Z3dpbjY0XGhv
bWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xnZW50b28tcHJlZml4XHVzclxiaW5c
Y3lnY3J5cHRvLTEuMS5kbGwpCiAgICAgIDIgW21haW5dIHB5dGhvbjIuNyAx
MDQ3MCBkbGxfbGlzdDo6cmVzZXJ2ZV9zcGFjZTogY3lnY3J5cHRvLTEuMS5k
bGwgcHJlZmVycmluZyAweDQxQzY1MDAwMCB3YXMgbG9hZGVkIHRvIDB4NzUw
MDAwIChcPz9cQzpcY3lnd2luNjRcaG9tZVxoYXViaVx0ZXN0LTIwMTkwMzI3
XGdlbnRvby1wcmVmaXhcdXNyXGJpblxjeWdjcnlwdG8tMS4xLmRsbCkKICAg
ICAgMiBbbWFpbl0gcHl0aG9uMi43IDEwNDczIGRsbF9saXN0OjpyZXNlcnZl
X3NwYWNlOiBjeWdjcnlwdG8tMS4xLmRsbCBwcmVmZXJyaW5nIDB4NDFDNjUw
MDAwIHdhcyBsb2FkZWQgdG8gMHg3NTAwMDAgKFw/P1xDOlxjeWd3aW42NFxo
b21lXGhhdWJpXHRlc3QtMjAxOTAzMjdcZ2VudG9vLXByZWZpeFx1c3JcYmlu
XGN5Z2NyeXB0by0xLjEuZGxsKQogICAgICAyIFttYWluXSBweXRob24yLjcg
MTA0NzYgZGxsX2xpc3Q6OnJlc2VydmVfc3BhY2U6IGN5Z2NyeXB0by0xLjEu
ZGxsIHByZWZlcnJpbmcgMHg0MUM2NTAwMDAgd2FzIGxvYWRlZCB0byAweDc1
MDAwMCAoXD8/XEM6XGN5Z3dpbjY0XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMy
N1xnZW50b28tcHJlZml4XHVzclxiaW5cY3lnY3J5cHRvLTEuMS5kbGwpCiAg
ICAgIDQgW21haW5dIHB5dGhvbjIuNyAxMDQ3OSBkbGxfbGlzdDo6cmVzZXJ2
ZV9zcGFjZTogY3lnY3J5cHRvLTEuMS5kbGwgcHJlZmVycmluZyAweDQxQzY1
MDAwMCB3YXMgbG9hZGVkIHRvIDB4NzUwMDAwIChcPz9cQzpcY3lnd2luNjRc
aG9tZVxoYXViaVx0ZXN0LTIwMTkwMzI3XGdlbnRvby1wcmVmaXhcdXNyXGJp
blxjeWdjcnlwdG8tMS4xLmRsbCkKICAgICAgMiBbbWFpbl0gcHl0aG9uMi43
IDExOTQxIGRsbF9saXN0OjpyZXNlcnZlX3NwYWNlOiBjeWdjcnlwdG8tMS4x
LmRsbCBwcmVmZXJyaW5nIDB4NDFDNjUwMDAwIHdhcyBsb2FkZWQgdG8gMHg4
QTAwMDAgKFw/P1xDOlxjeWd3aW42NFxob21lXGhhdWJpXHRlc3QtMjAxOTAz
MjdcZ2VudG9vLXByZWZpeFx1c3JcYmluXGN5Z2NyeXB0by0xLjEuZGxsKQog
ICAgICAyIFttYWluXSBweXRob24yLjcgMjUzODcgZGxsX2xpc3Q6OnJlc2Vy
dmVfc3BhY2U6IGN5Z2NyeXB0by0xLjEuZGxsIHByZWZlcnJpbmcgMHg0MUM2
NTAwMDAgd2FzIGxvYWRlZCB0byAweEIyMDAwMCAoXD8/XEM6XGN5Z3dpbjY0
XGhvbWVcaGF1YmlcdGVzdC0yMDE5MDMyN1xnZW50b28tcHJlZml4XHVzclxi
aW5cY3lnY3J5cHRvLTEuMS5kbGwpCg==

--------------0F70C0C93567A7FE0D77CACF--
