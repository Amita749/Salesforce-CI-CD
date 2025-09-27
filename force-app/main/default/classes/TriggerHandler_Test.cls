@isTest
private class TriggerHandler_Test {

	private static final String TRIGGER_CONTEXT_ERROR = 'Trigger handler called outside of Trigger execution';

    private static String lastMethodCalled;

    private static TriggerHandler_Test.TestHandler handler;

    static {
        handler = new TriggerHandler_Test.TestHandler();
		handler.setTriggerContext(null,true);
        // Override its internal trigger detection
        handler.isTriggerExecuting = true;
    }

    @isTest
    static void testBeforeInsert() {
        beforeInsertMode();
        handler.run();
        System.assertEquals('beforeInsert', lastMethodCalled, 'last method should be beforeInsert');
    }

    @isTest
    static void testBeforeUpdate() {
        beforeUpdateMode();
        handler.run();
        System.assertEquals('beforeUpdate', lastMethodCalled, 'last method should be beforeUpdate');
    }

    @isTest
    static void testBeforeDelete() {
        beforeDeleteMode();
        handler.run();
        System.assertEquals('beforeDelete', lastMethodCalled, 'last method should be beforeDelete');
    }

    @isTest
    static void testAfterInsert() {
        afterInsertMode();
        handler.run();
        System.assertEquals('afterInsert', lastMethodCalled, 'last method should be afterInsert');
    }

    @isTest
    static void testAfterUpdate() {
        afterUpdateMode();
        handler.run();
        System.assertEquals('afterUpdate', lastMethodCalled, 'last method should be afterUpdate');
    }

    @isTest
    static void testAfterDelete() {
        afterDeleteMode();
        handler.run();
        System.assertEquals('afterDelete', lastMethodCalled, 'last method should be afterDelete');
    }

    @isTest
    static void testAfterUndelete() {
        afterUndeleteMode();
        handler.run();
        System.assertEquals('afterUndelete', lastMethodCalled, 'last method should be afterUndelete');
    }

  @isTest
    static void testLoopCountClass() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount();
        

        lc.increment();
        lc.increment();
        lc.increment();
        lc.increment();
        lc.increment();
        lc.increment();
       
    }

    @isTest 
    static void testGetHandlerName() {
        System.assertEquals('TestHandler', handler.getHandlerName(), 'handler name should match class name');
    }

    @isTest
    static void testVirtualMethods() {
        TriggerHandler h = new TriggerHandler();
        h.beforeInsert();
        h.beforeUpdate();
        h.beforeDelete();
        h.afterInsert();
        h.afterUpdate();
        h.afterDelete();
        h.afterUndelete();
    }

    private static void resetTest() {
        lastMethodCalled = null;
    }

    private static void beforeInsertMode() {
        handler.setTriggerContext('before insert', true);
    }

    private static void beforeUpdateMode() {
        handler.setTriggerContext('before update', true);
    }

    private static void beforeDeleteMode() {
        handler.setTriggerContext('before delete', true);
    }

    private static void afterInsertMode() {
        handler.setTriggerContext('after insert', true);
    }

    private static void afterUpdateMode() {
        handler.setTriggerContext('after update', true);
    }

    private static void afterDeleteMode() {
        handler.setTriggerContext('after delete', true);
    }

    private static void afterUndeleteMode() {
        handler.setTriggerContext('after undelete', true);
    }

    private class TestHandler extends TriggerHandler {

        public override void beforeInsert() {
            TriggerHandler_Test.lastMethodCalled = 'beforeInsert';
        }

        public override void  beforeUpdate() {
            TriggerHandler_Test.lastMethodCalled = 'beforeUpdate';
        }

        public override void beforeDelete() {
            TriggerHandler_Test.lastMethodCalled = 'beforeDelete';
        }

        public override void afterInsert() {
            TriggerHandler_Test.lastMethodCalled = 'afterInsert';
        }

        public override void afterUpdate() {
            TriggerHandler_Test.lastMethodCalled = 'afterUpdate';
        }

        public override void afterDelete() {
            TriggerHandler_Test.lastMethodCalled = 'afterDelete';
        }

        public override void afterUndelete() {
            TriggerHandler_Test.lastMethodCalled = 'afterUndelete';
        }
    }
}