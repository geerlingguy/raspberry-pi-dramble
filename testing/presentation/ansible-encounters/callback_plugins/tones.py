# (c) 2012, Michael DeHaan, <michael.dehaan@gmail.com>
# (c) 2017 Ansible Project
# (c) 2019 Jeff Geerling
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

# Make coding more python3-ish
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = '''
    callback: tones
    type: notification
    requirements:
      - whitelisting in configuration
      - the SoX command line program ('brew install sox' on macOS)
    short_description: play a note using software synthesizer
    version_added: N/A
    description:
      - This plugin will use the SoX program to play notes for tasks.
'''

import distutils.spawn
import platform
import subprocess
import os
import threading
import time

from ansible.plugins.callback import CallbackBase


class CallbackModule(CallbackBase):
    """
    makes Ansible much more exciting.
    """
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'notification'
    CALLBACK_NAME = 'tones'
    CALLBACK_NEEDS_WHITELIST = True

    def __init__(self):

        super(CallbackModule, self).__init__()

        self.synthesizer = distutils.spawn.find_executable('play')

        # plugin disable itself if play is not present
        # ansible will not call any callback if disabled is set to True
        if not self.synthesizer:
            self.disabled = True
            self._display.warning("Unable to find 'play' executable, plugin %s disabled" % os.path.basename(__file__))

    def tone(self, tone, length, delay):
        cmd = [self.synthesizer]
        if tone:
            time.sleep(delay)
            cmd.extend(('-q', '-n', 'synth', length, 'sin', tone))
        subprocess.call(cmd)

    def playbook_on_task_start(self, name, is_conditional):
        # define some defaults
        length = '0.75'
        delay = 0.5
        notes = {
            'G5': '783.99',
            'A5': '880.00',
            'F5': '698.46',
            'F4': '349.23',
            'C5': '523.25'
        }

        if name == 'C5':
            length = '1.25'

        # play the tone if it exists
        if name in notes.keys():
            thread = threading.Thread(target=self.tone, args=(notes[name], length, delay))
            thread.daemon = True
            thread.start()
