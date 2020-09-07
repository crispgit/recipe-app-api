import time
from django.db import connections
from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Pause execution until database is available"""
    def handle(self, *args, **options):
        """Handle the command"""
        self.stdout.write('Waiting for database')
        db_conn = None
        # if there is a connection error
        while not db_conn:
            try:
                db_conn = connections['default']
            except OperationalError:
                self.stdout.write('Database unavailable now, waiting 1 second')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('Database available!'))
