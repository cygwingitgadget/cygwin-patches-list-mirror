Return-Path: <cygwin-patches-return-2443-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12346 invoked by alias); 16 Jun 2002 11:14:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12331 invoked from network); 16 Jun 2002 11:14:19 -0000
Date: Sun, 16 Jun 2002 04:14:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <100171979873.20020616151345@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Patch to add NtShutdownSystem() to w32api
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------1B1454E3F5629A2"
X-SW-Source: 2002-q2/txt/msg00426.txt.bz2

------------1B1454E3F5629A2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 199

Hi!

  NtShutdownSystem() is crude no-caches-flushed-and-no-apps-notified
but almost always working way to restart nt system.

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
------------1B1454E3F5629A2
Content-Type: application/octet-stream; name="w32api-ntshutdownsystem.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="w32api-ntshutdownsystem.diff"
Content-length: 1428

SW5kZXg6IHdpbnN1cC93MzJhcGkvaW5jbHVkZS9udGRsbC5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KUkNTIGZpbGU6IHdpbnN1cC93MzJhcGkvaW5jbHVk
ZS9udGRsbC5oCmRpZmYgLU4gd2luc3VwL3czMmFwaS9pbmNsdWRlL250ZGxs
LmgKLS0tIC9kZXYvbnVsbAkxIEphbiAxOTcwIDAwOjAwOjAwIC0wMDAwCisr
KyB3aW5zdXAvdzMyYXBpL2luY2x1ZGUvbnRkbGwuaAkxNiBKdW4gMjAwMiAx
MTowNjozNSAtMDAwMApAQCAtMCwwICsxLDE1IEBACisjaWZuZGVmIF9OVERM
TF9ICisjZGVmaW5lIF9OVERMTF9ICisjaWYgX19HTlVDX18gPj0zCisjcHJh
Z21hIEdDQyBzeXN0ZW1faGVhZGVyCisjZW5kaWYKKwordHlwZWRlZiBlbnVt
IF9TSFVURE9XTl9BQ1RJT04geworICAgICBTaHV0ZG93bk5vUmVib290LAor
ICAgICBTaHV0ZG93blJlYm9vdCwKKyAgICAgU2h1dGRvd25Qb3dlck9mZgor
IH0gU0hVVERPV05fQUNUSU9OOworCitEV09SRCBXSU5BUEkgTnRTaHV0ZG93
blN5c3RlbSAoU0hVVERPV05fQUNUSU9OIEFjdGlvbik7CisKKyNlbmRpZiAv
KiBfTlRETExfSCAqLwpJbmRleDogd2luc3VwL3czMmFwaS9saWIvbnRkbGwu
ZGVmCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvdWJl
cmJhdW0vd2luc3VwL3czMmFwaS9saWIvbnRkbGwuZGVmLHYKcmV0cmlldmlu
ZyByZXZpc2lvbiAxLjEKZGlmZiAtdSAtMiAtcjEuMSBudGRsbC5kZWYKLS0t
IHdpbnN1cC93MzJhcGkvbGliL250ZGxsLmRlZgkxNiBKdW4gMjAwMiAwNzox
OTozNCAtMDAwMAkxLjEKKysrIHdpbnN1cC93MzJhcGkvbGliL250ZGxsLmRl
ZgkxNiBKdW4gMjAwMiAxMTowNjozNSAtMDAwMApAQCAtMzEsNCArMzEsNSBA
QAogTnRSZWFkRmlsZUAzNg0KIE50UmVhZFZpcnR1YWxNZW1vcnlAMjANCitO
dFNodXRkb3duU3lzdGVtQDQNCiBOdFVubG9ja1ZpcnR1YWxNZW1vcnlAMTYN
CiBOdFdyaXRlRmlsZUAzNg0K

------------1B1454E3F5629A2
Content-Type: application/octet-stream; name="w32api-ntshutdownsystem.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="w32api-ntshutdownsystem.ChangeLog"
Content-length: 151

MjAwMi0wNi0xNiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBp
bmNsdWRlL250ZGxsLmg6IE5ldyBmaWxlLgoJKiBsaWIvbnRkbGwuZGVmOiBB
ZGQgTnRTaHV0ZG93blN5c3RlbS4K

------------1B1454E3F5629A2--
